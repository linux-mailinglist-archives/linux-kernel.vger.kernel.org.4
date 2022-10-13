Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A25FE357
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJMUdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJMUdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7E15B321
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665693210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4mKieH5GwNMnvwgRs+kFclyzofty9rpxeY92yAwuAjA=;
        b=EWXuhCGAS5Cz3W16KgpVOFhpvhgohYkA4T5jevQcD69KTR/gxWcPQYN0K76rO+UBN7M2cy
        uJD+UFqj7AdK4WGLVbwVWmyciwEO0Cus9d4SKOd2D+sSLCBZpGc4x+DYfdN3bp6KYSbxo6
        5v88es7v/ob0JbjALnsA/MslgxYUH3k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-N9tI7VSKOgi5DEiBNyVpsg-1; Thu, 13 Oct 2022 16:33:26 -0400
X-MC-Unique: N9tI7VSKOgi5DEiBNyVpsg-1
Received: by mail-ed1-f69.google.com with SMTP id b13-20020a056402350d00b0045d0fe2004eso438853edd.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4mKieH5GwNMnvwgRs+kFclyzofty9rpxeY92yAwuAjA=;
        b=w701ojv6mq3SbVJkT9Fq4SqDj6ooX8ravH4rWdWMLAUfSpw1rt42kZTfq1K2rrENHq
         9/5TYoOTWsrFRmvqCCki94B9a/DQeAWT7Hc/TWBuEd2u3vy+ocGz93u9h7aqPJycMbPZ
         hfmV1BP15OeAD7P25fqAkEd538CDJ0ibQLqxqA/Kh1D6VNaQ05Thfh0Dgj/3ceGIJMZs
         MpkisTPOrZ7UwK+dwpbl0c3+61pVGGaw0DdpavC9boHBXsNQFdOEQQCoDOPuFOsAulyR
         hSVaRS7Gz1iphVKf5flvlYCXzepFNHeWSgubJTgbMYK0ZOVn9/xAvYrFJRR46zVOoTgn
         Pu5w==
X-Gm-Message-State: ACrzQf2OKGdKUReQaUtc55o/NBSvItGAlKp4U1mCuOUlfpXNXg+2xOUF
        pc5CjXhrUZSB4umGKpghgFLUj/apb8bW6iPqT/uSSsqeljx1kDe8hyZSg31jGtXxKqME6BpSrD5
        Epw31ZAmeNqkbmVej4gGB4M83
X-Received: by 2002:a17:907:2da7:b0:78e:4ea:dbf7 with SMTP id gt39-20020a1709072da700b0078e04eadbf7mr1103263ejc.616.1665693205574;
        Thu, 13 Oct 2022 13:33:25 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5n6kqWrrQYhfEYMmrV7QHRbWoJZRfPDHPTK4rYETvlI2sUdapgVjFGZHJ32EiRj5vfkkn9qw==
X-Received: by 2002:a17:907:2da7:b0:78e:4ea:dbf7 with SMTP id gt39-20020a1709072da700b0078e04eadbf7mr1103249ejc.616.1665693205330;
        Thu, 13 Oct 2022 13:33:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ky23-20020a170907779700b0078a86e013c4sm396179ejc.61.2022.10.13.13.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 13:33:24 -0700 (PDT)
Message-ID: <355dde1c-91e3-13b5-c8e8-75c9b9779b4f@redhat.com>
Date:   Thu, 13 Oct 2022 22:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US, nl
To:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: alderlake crashes (random memory corruption?) with 6.0 i915 / ucode
 related
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Yesterday I got a new Lenovo ThinkPad X1 yoga gen 7 laptop, since I plan
to make this my new day to day laptop I have copied over the entire
rootfs, /home, etc. from my current laptop to avoid having to tweak
everything to my liking again.

This meant I had an initramfs generated for the other laptop. Which should
be fine since both are Intel machines and the old 5.19.y initramfs-es
worked fine. But 6.0.0 crashed with what seems like random memory
corruption (list integrity checks failing) until I regenerated the initrd ...

Comparing the old vs regenerated initrds showed no relevant differences,
which made me think this is a CPU ucode issue (which is pre-fixed
to the initrd for early microcode loading).

After some tests I have the following obeservations with 6.0.0:

1. The least stable is the old initrd (so with the wrong
ucode prefixed) this crashes before ever reaching gdm.
I believe that this is caused by late microcode loading
kicking in in this case (I though that was being removed?)
and doing load microcode loading on the i7-1260P with its
mix of P + E cores seems to seriously mess things up.

2. Slightly more stable, lasting at least a few minutes
before crashing is using dis_ucode_ldr

3. Using nomodeset seems to stabilize things even with
the old initrd with the wrong microcode prefixed

4. 5.19, with an old initrd and with normal modesetting
enabled works fine, so in a way this is a 6.0.0 regression

5. Using 6.0 with the new initrd with the new microcode
seems mostly stable, although sometimes this seems to 
hang very early during boot, esp. if a previous boot
crashed and I have not run this for a long time yet.

6. After crashes it seems to be necessary to powercycle
the machine to get things back in working condition.


With 6.0 the following WARN triggers:
drivers/gpu/drm/i915/display/intel_bios.c:477:

        drm_WARN(&i915->drm, min_size == 0,
                 "Block %d min_size is zero\n", section_id);

Since nomodeset helps this might be quite relevant, in 5.19.13
this does not happen, but I'm not sure if 5.19 has this check
at all.


There is a 2022/10/07 BIOS update which includes a CPU microcode
update available from Lenovo, I have not applied this yet in case
people want to investigate this further first.

Regards,

Hans


