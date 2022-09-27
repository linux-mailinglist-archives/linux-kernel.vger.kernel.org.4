Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A655ECABA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiI0RYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiI0RYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:24:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF462EA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:24:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id lc7so22269091ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3c45jsBfv/NH6ArNEDI+dXny5k9HP9bISyg7K6ga1ts=;
        b=A9smj7vz+qXIDrXFOce54GGadi4+0MBQ64+xEpFiyzmPvWsnPMC0Iv0pQvXnMOvAwt
         B0V7G+EO3Uyv8jlRg4lx7PG7tN4x3a0ZaLlowekA/sq3IGrjgz99SKnfo77padvYjMPC
         aPi5MNfgEywdVKsbE47fcqyp9YlaUUxZqws397f82lE9YCT/bNgWXVvIm1+VUbc180xZ
         xyA3j1qPIUwvr+YnKT/x9QG/6qLcuiEJs2wKzSvI+TmdMxST4veC+xfWU91w4q6AnR+L
         H/OK0V+o1/HleO3nO3U0uj1kW3bObARHtXVR2iSWvwq7M6vflC9bTgO1bQvcihYUHGiG
         4OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3c45jsBfv/NH6ArNEDI+dXny5k9HP9bISyg7K6ga1ts=;
        b=O0k5B6Ypxj76s19xFtjDNVi7iMDDVuxYd2ypQzI/5+uYXrRD/2bkm6pl1hHfQfsF1h
         VA7wdY6LHmy9nmlxY9o4Fc36/aNRBqz7zKyz5fihO5j7cmMUUa+zu0oRC3U1isb/9mO0
         2a3CRhO1yYLiW5/ZSHrrUjPq6NTEbxFeRkVwAf2XKrNk2g8fJxwg8PSYC2tl0dDimttE
         CaeOfIuB7E9IvPJ2uLcJTV52MsUbLOtb7AAJLT8ow0w11oPX0qg78lfhQIZpc0w2uLns
         p42209DL2K2GekZLUr3gjd4f1ktUpD6+OvdqHuvdH6EeaGtJyc1WOvCEDDk5AcFyb473
         QuGQ==
X-Gm-Message-State: ACrzQf21/JlnB99WRUTH5AKylz/00QZlcGhA7/MUkJKjk+NnIi9xmzfc
        fwJpUJZgQtDTtuENG7jGAao=
X-Google-Smtp-Source: AMsMyM6bVGEoBNsDGah9Y6IQGvNvYH0w0SrpNOSHA4CTKcxN33annU5SfoYAToZI6Zn8b3kERzk/0A==
X-Received: by 2002:a17:907:9602:b0:780:8c9f:f99a with SMTP id gb2-20020a170907960200b007808c9ff99amr24136114ejc.465.1664299475905;
        Tue, 27 Sep 2022 10:24:35 -0700 (PDT)
Received: from [192.168.2.30] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id m9-20020a509989000000b0045391f7d877sm1715837edb.53.2022.09.27.10.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 10:24:35 -0700 (PDT)
Message-ID: <1a5e3ecd-04f5-cdd6-a284-a4c9d0999f11@gmail.com>
Date:   Tue, 27 Sep 2022 19:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [dm-devel] [PATCH] kernfs: fix a crash when two processes delete
 the same directory
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Christoph Lameter <cl@linux.com>
References: <alpine.LRH.2.02.2209260418360.16612@file01.intranet.prod.int.rdu2.redhat.com>
 <YzGYFBv0pdt+DQg+@kroah.com> <6c75a90d-3793-55fc-e525-eca14e562350@gmail.com>
 <YzMYuAaHRpydr7Fy@kroah.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <YzMYuAaHRpydr7Fy@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 17:37, Greg Kroah-Hartman wrote:
> On Tue, Sep 27, 2022 at 05:22:46PM +0200, Milan Broz wrote:
>> On 9/26/22 14:16, Greg Kroah-Hartman wrote:
>>> On Mon, Sep 26, 2022 at 07:04:52AM -0400, Mikulas Patocka wrote:
>>>> There is a crash when running the cryptsetup testsuite on Fedora Rawhide.
>>>> It can be reproduced by installing Rawhide with the 6.0-rc6 kernel,
>>>> downloading and compiling the cryptsetup repository and running this test
>>>> in a loop for about 15 minuts:
>>>> 	while ./integrity-compat-test; do :; done
>>>>
>>>>    ------------[ cut here ]------------
>>>>    WARNING: CPU: 0 PID: 50087 at fs/kernfs/dir.c:504 __kernfs_remove.part.0+0x26f/0x2b0
>>>>    Modules linked in: crc32_generic loop dm_integrity async_xor async_tx tls isofs uinput snd_seq_dummy snd_hrtimer nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr sunrpc snd_hda_codec_generic ledtrig_audio snd_hda_intel iTCO_wdt snd_intel_dspcfg intel_pmc_bxt snd_intel_sdw_acpi iTCO_vendor_support snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device joydev snd_pcm i2c_i801 snd_timer pcspkr i2c_smbus virtio_balloon snd lpc_ich soundcore zram virtio_net net_failover virtio_blk serio_raw failover qxl virtio_console drm_ttm_helper ttm ip6_tables ip_tables fuse qemu_fw_cfg
>>>>    Unloaded tainted modules: crc32_pclmul():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 edac_mce_amd():1 acpi_cpufreq():1 pcc_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 edac_mce_amd():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1
>>>>    CPU: 0 PID: 50087 Comm: integritysetup Not tainted 6.0.0-0.rc6.41.fc38.x86_64 #1
>>>>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
>>>>    RIP: 0010:__kernfs_remove.part.0+0x26f/0x2b0
>>
>> ...
>>
>>> Can you see if 4abc99652812 ("kernfs: fix use-after-free in
>>> __kernfs_remove") in linux-next fixes this for you or not?  It seems to
>>> be the same issue, as was also reported at:
>>> 	https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
>>
>>
>> I tried it on system where cryptsetup testsuite almost immediately crashed in the integrity test.
>>
>> With the patch in https://lore.kernel.org/r/7f489b14-2fdc-3d91-c87e-6a802bd8592d@I-love.SAKURA.ne.jp
>> it now iterates for some time without any problems, so I think it is fixed.
>>
>> Tested-by: Milan Broz <gmazyland@gmail.com>
> 
> Wait, what about the patch that is in linux-next that I pointed to, not
> the one in the email?

Ehm, yes, my mistake.

Now tested 4abc99652812 (it is not visible in any branch anymore, perhaps rebased).

Already running several iterations and no problems, so for the correct patch now:

Tested-by: Milan Broz <gmazyland@gmail.com>

Milan
