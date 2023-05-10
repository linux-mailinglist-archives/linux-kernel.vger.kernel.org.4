Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE016FDC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbjEJLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbjEJLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:01:00 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9B2102;
        Wed, 10 May 2023 04:00:57 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so67654591a12.1;
        Wed, 10 May 2023 04:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683716456; x=1686308456;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jN8Aq5FPpTGT1iEz1Qibhge7nHg3W8S6IukcnA1rLJs=;
        b=Ka21o6/aTnVF7QxoBAedmbFD/WSc64NQR+z+k0+hdpONgv5UDwY6REYffmS9LpV8o0
         KfhKLwSUUjaTA6tv+mycvyGvYyn6tw4/Io2BLU54eqUTmNoIU68dR8hhVZ1gfzZfqmk5
         BrASUKIqTa5ohPgrFrGtQB5dxUzi/6jEqjafoyCgG62xLp6ju2EmDeU9ClvCC3mBOMiG
         ljADfyg7F/mXQ+agc4rGQFUTFfRDKa1pJZP2Rmd+m2LwgHT9YSHluPaf36p794voaWIp
         J2S2BT+uitZxQs/xAYNdjUGcgIvgBycKfjlhNFWDL3H/t4i5FMw7ENWWqycYg/7uihzM
         ZjZg==
X-Gm-Message-State: AC+VfDyPYwAiJPM5u8+HcyYwvrbq1MXHaaq93IFtzpSfweOtNUEsK0IC
        zBSJCTa+5ZEfYEyjMYpBQvg=
X-Google-Smtp-Source: ACHHUZ4sTK7JZjZwEPcQNhZrPqaKoUvD88ysV1xqCI+I3ekCSPJGfAIEx3Xw8KISbPB6Vve4LqCuIA==
X-Received: by 2002:aa7:cb11:0:b0:504:a3ec:eacc with SMTP id s17-20020aa7cb11000000b00504a3eceaccmr14624020edt.4.1683716456162;
        Wed, 10 May 2023 04:00:56 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0050bc41352d9sm1731271edu.46.2023.05.10.04.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 04:00:55 -0700 (PDT)
Message-ID: <4cb758c7-f4f5-820c-c7e7-5b900ccc2534@kernel.org>
Date:   Wed, 10 May 2023 13:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        YehezkelShB@gmail.com, USB list <linux-usb@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: make localmodconfig doesn't work for thunderbolt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I use localmodconfig for example like this:
mkdir /tmp/tb/
echo thunderbolt >/tmp/tb/lsmod
make O=/tmp/tb LSMOD=/tmp/tb/lsmod localmodconfig

I get:
using config: '.config'
thunderbolt config not found!!

$ grep 'USB4\>' /tmp/tb/.config
# CONFIG_USB4 is not set

I believe it's due to:
   obj-${CONFIG_USB4} := thunderbolt.o
in drivers/thunderbolt/Makefile. I.e. ${} used instead of more common $().

But even if I change the parser:

--- a/scripts/kconfig/streamline_config.pl
+++ b/scripts/kconfig/streamline_config.pl
@@ -317,7 +317,7 @@ foreach my $makefile (@makefiles) {
         $_ = convert_vars($_, %make_vars);

         # collect objects after obj-$(CONFIG_FOO_BAR)
-       if (/obj-\$\((CONFIG_[^\)]*)\)\s*[+:]?=\s*(.*)/) {
+       if (/obj-\$[({](CONFIG_[^})]*)[)}]\s*[+:]?=\s*(.*)/) {
             $var = $1;
             $objs = $2;


I see:
module thunderbolt did not have configs CONFIG_USB4

and:
$ grep 'USB4\>' /tmp/tb/.config
# CONFIG_USB4 is not set

So two questions:
1) is ${} supported and should be the above change sent as a patch? Or 
should be drivers/thunderbolt/Makefile fixed to use $(). (And maybe 
other Makefiles too.)

2) how to fix that 'thunderbolt did not have configs'?

thanks,
-- 
js
suse labs
