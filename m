Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5F174A84E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGGBDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGGBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26D9172B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688691758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yyqbpHCBj1owppJL9+7IUc8i+R1e/YK0bJp67wQ+M4=;
        b=eaN2QJI+07XHTE31OTtw0W3KcLcnLCEPulYEcgvnDzbvzfi+6fwxUyYJIMMUHb5hbJDvtl
        hwMr/bOMpmDzGsqriC9FsdJXZ2ih9/lhI5Bfb/z0dGB+YafC9xxpB3xPJ5/aBJrfb2iJBz
        XDGKM4tt33cp5zXdwi1AR+8UgVevCjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-YTUVvhpkPzS6e8xMtzWI9Q-1; Thu, 06 Jul 2023 21:02:32 -0400
X-MC-Unique: YTUVvhpkPzS6e8xMtzWI9Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B66858F1E;
        Fri,  7 Jul 2023 01:02:31 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E14F492B02;
        Fri,  7 Jul 2023 01:02:22 +0000 (UTC)
Date:   Fri, 7 Jul 2023 09:02:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v6 2/3] ublk: add helper to check if device supports user
 copy
Message-ID: <ZKdkGZBLINFV8cbj@ovpn-8-34.pek2.redhat.com>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706130930.64283-3-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 03:09:29PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This will be used by ublk zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

