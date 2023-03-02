Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF496A8A14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 21:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCBUSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 15:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:18:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810F0580DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677788256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=q/XkoiHEn5CYXOMUyWsTQx8nVa/mlQeTCj8fE3wle7I=;
        b=iIcqze0FRP3M1NLFo/E5jm2w8nT9s4AC+pDF+R9ScqzNSm7RugR8f6aDXece5gV3JKbZbe
        VIW4SkKEgsQy9riGJfWn1orC2k7/V/fspE+ngLSWkG3Hb99V3AmflfScdJhFD0NpdJyidq
        3skNtTUkD3TnN4hVTlj8GPJh0LaPJi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-vF-ltVysOy2ryhvcN-V_3Q-1; Thu, 02 Mar 2023 15:17:33 -0500
X-MC-Unique: vF-ltVysOy2ryhvcN-V_3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0767C85A5B1;
        Thu,  2 Mar 2023 20:17:33 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF2A01121315;
        Thu,  2 Mar 2023 20:17:32 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id A939BC042A; Thu,  2 Mar 2023 15:17:32 -0500 (EST)
Date:   Thu, 2 Mar 2023 15:17:32 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Error reports at boot time in Ampere Altra machines since c733ebb7c
Message-ID: <20230302201732.pwnhg46mum6st2bv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Since c733ebb7cb67d ("irqchip/gic-v3-its: Reset each ITS's BASERn
register before probe"), Ampere Altra machines are reporting corrected
errors during boot:

	[    0.294334] HEST: Table parsing has been initialized.
	[    0.294397] sdei: SDEIv1.0 (0x0) detected in firmware.
	[    0.299622] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 0
	[    0.299626] {1}[Hardware Error]: event severity: recoverable
	[    0.299629] {1}[Hardware Error]:  Error 0, type: recoverable
	[    0.299633] {1}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
	[    0.299638] {1}[Hardware Error]:   section length: 0x30
	[    0.299645] {1}[Hardware Error]:   00000000: 00000005 ec30000e 00080110 80001001  ......0.........
	[    0.299648] {1}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
	[    0.299650] {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
	[    0.299714] {2}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
	[    0.299716] {2}[Hardware Error]: event severity: recoverable
	[    0.299717] {2}[Hardware Error]:  Error 0, type: recoverable
	[    0.299718] {2}[Hardware Error]:   section type: unknown, e8ed898d-df16-43cc-8ecc-54f060ef157f
	[    0.299720] {2}[Hardware Error]:   section length: 0x30
	[    0.299722] {2}[Hardware Error]:   00000000: 40000005 ec30000e 00080110 80005001  ...@..0......P..
	[    0.299724] {2}[Hardware Error]:   00000010: 00000300 00000000 00000000 00000000  ................
	[    0.299726] {2}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
	[    0.299912] GHES: APEI firmware first mode is enabled by APEI bit.

Because the errors are being reported later in boot, it's hard to
pinpoint exactly what's causing it without decoding the error information,
which I currently don't know how to do it.

There're no problems other than of course triggering tests because of
the warnings.

Do you know what's going on here?

Thanks

-- 
Aristeu

