Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB916692064
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjBJOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbjBJOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BF66A707
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676037688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzeORwJPvkQ2Gq2J93A9ERHfB47SEtRCtLFDmd4aEM4=;
        b=BgIlPfRiGob6Vh1biw5THOzVeE7F9zh/Y5UBolfhQoKghQZo6Bn1i3mQGFD6ZJb+xGCyr0
        uYSC3/CiKpI/Ju/z1ngX1cURnpySyAcW1HD4wUUnaLhAI91E3ViGx3r+UlOVCYPK9NL+3q
        nnlcr+pyuhZQI14d9lLK8hv5w3x1bcg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-dEpdtMfCOUiKAs-ik_IDbQ-1; Fri, 10 Feb 2023 09:01:25 -0500
X-MC-Unique: dEpdtMfCOUiKAs-ik_IDbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3FCF88B776;
        Fri, 10 Feb 2023 14:01:24 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-195-1.brq.redhat.com [10.40.195.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88AEE40CF8F0;
        Fri, 10 Feb 2023 14:01:20 +0000 (UTC)
Date:   Fri, 10 Feb 2023 15:01:16 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Message-ID: <20230210140100.z3of7kzj6lpnugu7@mail.corp.redhat.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
 <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
 <20230210232043.18483401@redecorated-mbp>
 <BM1PR01MB0931E8F14D84CFB59EABEBA4B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BM1PR01MB0931E8F14D84CFB59EABEBA4B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10 2023, Aditya Garg wrote:
> 
> > Were the changes needed for these structs to be const in the
> > linux-input tree for 6.3? If so then if you're applying the patches
> > onto linus' tree that might be why there are errors about consts.
> 
> I’d want the maintainers comment on this. Imo, these 2 structures needn’t be constantified.

The struct hid_ll_driver has to be constified, because otherwise it will
introduce an error/warning when this patch is merged in the hid tree.

For the struct hid_driver, as mentioned previously I don't think we have
the hid-core changes for that, and so you can't really constify them.

Cheers,
Benjamin

> 
> Also, it would be nice if we could get a review on the other 2 patches, so that a v2 can be prepared.

