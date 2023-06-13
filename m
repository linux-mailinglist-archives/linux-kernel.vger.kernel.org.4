Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6E572D6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbjFMBCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjFMBCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6910E3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686618106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ai904PU5tZSyzOhImHs8NZvABJ0V9E9IGYDkNgwWjGE=;
        b=TGlkZOb0uV19obiot2zUDMd7qZRcM/HscuF/RmhcMUErH9xq4hxusmYX6XWvfKZde5lhnV
        gqBE6aRPTZ8VU+QF564tNRRYJC+txVB5g02RdBDaVKIxPLxEak6aiP0Md99Q/Je7g3kjMe
        zKLa4YLPXensBdDq2MXbTURRAM+ewtg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-nDU0hmGwMRCe7h-Oy5152A-1; Mon, 12 Jun 2023 21:01:41 -0400
X-MC-Unique: nDU0hmGwMRCe7h-Oy5152A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7B3801224;
        Tue, 13 Jun 2023 01:01:40 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52690C1604D;
        Tue, 13 Jun 2023 01:01:35 +0000 (UTC)
Date:   Tue, 13 Jun 2023 09:01:31 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] nvme-tcp: fix hung issues for deleting
Message-ID: <ZIe/66eA5TMeYZ1U@ovpn-8-16.pek2.redhat.com>
References: <cover.1685350577.git.chunguang.xu@shopee.com>
 <ZH9NcBtrDxwq5xRU@ovpn-8-17.pek2.redhat.com>
 <CADtkEeeVWZ_b9mDWzwaq_5hdfZ53-RX2rd1SDDem=YsSBQ_g8A@mail.gmail.com>
 <ZIEnQpAgeqm0xcQP@ovpn-8-23.pek2.redhat.com>
 <febff498-63e6-efe2-2f5a-9a9fa7e767c0@grimberg.me>
 <ZIZ10UGQOJCWgjkX@ovpn-8-23.pek2.redhat.com>
 <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a17d0f9-c624-2b30-476e-1a039f978c4e@grimberg.me>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Mon, Jun 12, 2023 at 09:36:53AM +0300, Sagi Grimberg wrote:
>
...

> > 
> > Not yet, will do it.
> 
> Would like it to get to the next pull request going out this week...

The two patches have been sent out:

https://lore.kernel.org/linux-nvme/20230613005847.1762378-1-ming.lei@redhat.com/T/#t

thanks,
Ming

