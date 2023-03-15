Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7F6BA585
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCODKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCODKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:10:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8223328
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:10:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a2so18656567plm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112; t=1678849828;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0o3VwfPR2cLzg5vBfLTssUbP9mVO5G8lO12zWDvqTuo=;
        b=3r2znFq8V0L0lb1M+m7WVJI+DvR0L4/m/vGI+lZX8crozrsY0hWt5jO/lS/Qs9lpuY
         XXzcDXbovaqXncE799EZQ59xDChUO5KyizsjFqItZG2oYoTb8ISTXnohIvCn8DRG8Jd4
         VKmNlbwQCezzynkCapPoE0Ax30F0XAqwbqYpZRuR+Dcildqcsc+vFU+DbVkXJSnJelU6
         A4GZWJmilLNUvReGszKrbjZHiIzfVK5BTtBj118yq9bFraVrhgjMVpdEU9raoWqxrLyF
         wn8Nk8tSdyMGzzn0mm4C6Rqz+z/MaTB0692ojrG2WNeLW8KyJDO+iHbpI3uYRAsdoCMJ
         b8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849828;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o3VwfPR2cLzg5vBfLTssUbP9mVO5G8lO12zWDvqTuo=;
        b=kGlb8CrezNk4F9bRJgpk7HEd03DZ4HXHfLdfXHVAKTctatn7ZXbWpEyEoK6+F4ENwA
         UIdiMEjZ+K9bkoGJv5dEXEs9Bppr+JKmXhm1LXN6ESRpaGLYb1OXzfIp/20omQLX0F/n
         Dpf5Y8D/9VuLLFSGn9iFWrB0kCEXsU8jV7051m4AT4gCZNp5MtcFssrgp/AoDmUzXxFR
         APLrT5Z8NNTc5ZAmaxH1c3P/UxO+sNaZjgqRo60yJdxeyaKr4FFYPeK85Ko2oM9zkOaK
         xJibVCr4dTAEdGPIXYEAb2Sju276ji5Y5li6nkSrudIurLe0vSr76VnI2FKfo2R2URaQ
         py5Q==
X-Gm-Message-State: AO0yUKXG+EKZhM9OoxcnQKH1fcwN8XZEvlz1sahsk98MfunSNPzdayyZ
        hJTmnngm312feJP/qKO/7BcadA==
X-Google-Smtp-Source: AK7set9o/IdveqFEi+34PRXS3foRlDleO+WT9363xelftZvGpD139okSvfBC74nLf1bpP4TAr2O1nA==
X-Received: by 2002:a17:902:cad5:b0:19f:1f0a:97f1 with SMTP id y21-20020a170902cad500b0019f1f0a97f1mr919209pld.30.1678849828320;
        Tue, 14 Mar 2023 20:10:28 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902820900b001a0448731c2sm2452709pln.47.2023.03.14.20.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 20:10:27 -0700 (PDT)
Date:   Tue, 14 Mar 2023 20:10:27 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Mar 2023 20:09:07 PDT (-0700)
Subject:     Re: [PATCH 1/3] kernel/reboot: Use the static sys-off handler for any priority
In-Reply-To: <0a8358cd-4c2e-ed70-2cc5-1cff27b7594d@collabora.com>
CC:     samuel@sholland.org, rafael.j.wysocki@intel.com,
        aou@eecs.berkeley.edu, apatel@ventanamicro.com,
        Atish Patra <atishp@rivosinc.com>, geert@linux-m68k.org,
        heiko@sntech.de, kai.heng.feng@canonical.com, mcgrof@kernel.org,
        paulmck@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        pmladek@suse.com, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        tangmeng@uniontech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dmitry.osipenko@collabora.com, linux-pm@vger.kernel.org,
        rafael@kernel.org
Message-ID: <mhng-480cc68b-261d-4ef2-a67a-205a154c3895@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2023 15:32:06 PST (-0800), dmitry.osipenko@collabora.com wrote:
> On 2/19/23 02:20, Samuel Holland wrote:
>> On 2/14/23 18:17, Palmer Dabbelt wrote:
> ...
>>> Sorry for being slow here, I'd been assuming someone would Ack this but
>>> it looks like maybe there's nobody in the maintainers file for
>>> kernel/reboot.c?  I'm fine taking this via the RISC-V tree if that's OK
>>> with people, but the cover letter suggests the patch is necessary for
>>> multiple patch sets.
>>
>> See also Dmitry's reply[0] to the PSCI thread. (Maybe I should have sent
>> both conversions as one series?)
>>
>> I am happy with the patches going through any tree. The kernel/reboot.c
>> patch is exactly the same between the two series, so it should not hurt
>> if it gets merged twice. Though if you take this series through the
>> RISC-V tree, maybe you want to create a tag for it?
>>
>> I am not sure exactly what needs to be done here; I am happy to do
>> anything that would assist getting both series merged for v6.3, to avoid
>> a regression with axp20x[1].
>>
>> Regards,
>> Samuel
>>
>> [0]:
>> https://lore.kernel.org/lkml/0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com/
>> [1]:
>> https://lore.kernel.org/lkml/e38d29f5-cd3c-4a2b-b355-2bcfad00a24b@sholland.org/
>
> The reboot.c changes should be acked/applied by Rafael.
> I noticed that you haven't CC'd the linux-pm ML, maybe that's why it
> hasn't got the attention.

OK, I'm adding them here.  Not sure if we're ment to re-send it to the 
list, no rush on my end I'm just scrubbing through some old stuff on 
patchwork again.
