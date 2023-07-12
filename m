Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D62E750BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjGLPBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjGLPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981C1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689173996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GgLJ4eusXVkn+2KiPoPw0Jwn/b0n/YlKgCsmpR3oN+k=;
        b=D0ZpWjihysKxbAn00/tG50vINmPZ6xAUJ0+MnFUt0SrvEhlYr0l62msq7lta/uNQSVgFyj
        N+/LohO1Oky8fstbO0a22IGDggzBHYap/Dh+Qa0JoWvDSWcNMwZh2r7JozqkoKTr9tPI9s
        xQxw3SIC2TIxke2srcka4bNRe+4zTGQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-724vObnAPWe6k5MXk9AEQQ-1; Wed, 12 Jul 2023 10:59:46 -0400
X-MC-Unique: 724vObnAPWe6k5MXk9AEQQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CC77280460E;
        Wed, 12 Jul 2023 14:59:45 +0000 (UTC)
Received: from ovpn-8-25.pek2.redhat.com (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E1853492B01;
        Wed, 12 Jul 2023 14:59:36 +0000 (UTC)
Date:   Wed, 12 Jul 2023 22:59:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        open list <linux-kernel@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Johannes Thumshirn <jth@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH v8 1/2] ublk: add helper to check if device supports user
 copy
Message-ID: <ZK6/0TKxe2q4/hi9@ovpn-8-25.pek2.redhat.com>
References: <20230711072353.200873-1-nmi@metaspace.dk>
 <20230711072353.200873-2-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711072353.200873-2-nmi@metaspace.dk>
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

On Tue, Jul 11, 2023 at 09:23:52AM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This will be used by ublk zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

BTW, both Damien and I have reviewed this one, and you can put the
reviewed-by tag in patch.

Thanks,
Ming

