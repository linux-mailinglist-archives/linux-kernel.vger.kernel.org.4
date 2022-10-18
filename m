Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10234602638
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJRHyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJRHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F11771BD4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666079646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2F+GJ1yS9I/3gQmwXrWo3ysZ03ASLb2Zkeo7BUrp7yI=;
        b=GL6JB+lg4gcRn7oE6jktjcGTIbukvB49XGR+7HnRRivG0kAZ05H4Jf8rCDcVlpkNip1jUu
        sbMEs7HFw+LxG+FaEsryjysQTBVwSbOt9ZrivTu29CKZGr26cPUEOZH4LI3rdCBZMzIGQL
        R0LNVCZz6mQ26vONlD7FCYOJvTrZ5Os=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-519-krTfvoDNNM2K6AKliuvleA-1; Tue, 18 Oct 2022 03:54:02 -0400
X-MC-Unique: krTfvoDNNM2K6AKliuvleA-1
Received: by mail-wm1-f70.google.com with SMTP id i203-20020a1c3bd4000000b003c6d18a7ee5so31538wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2F+GJ1yS9I/3gQmwXrWo3ysZ03ASLb2Zkeo7BUrp7yI=;
        b=NkQMmquIDd5NtT0xdfFot9PwRoiGoYhEd7Rl0kt5gcAGgeLcLGJBPKoGWleEJBbgs/
         RSBSA1cS1wPsbcR7uZQGuTsu7L36fGlcIYZVmvifu+6/FyqTf1Ab941U4J/53ihmqU9B
         IwTnTvkHrROx7vWiERK+M87XI7ima50B3RFuxrpaqg039mBj/czfGkJDk/B/qBKTDbEd
         bGuIiESrZF9D8eLnW1R5lQ4dWb7EoYnM8TVXVkqnzRQtd3Sv39Gzv6rQ6T7l/7OOJZXx
         hevEY26BhVo3SbfqFJ1ZH6XFMpxzBfS1Z2h74q9485zJoNpCTJH5g7sVXLP2nE8v6Vh2
         MAnw==
X-Gm-Message-State: ACrzQf3iDHBEY511HWcIyn+ysCnEkrx8mOZaM87u5M1twCo02pCac625
        IT8pqFJgWLeFLDa7TXjCWa4Of206elfNUG7rImcdD9+5pNUsOy64OotsgMVDjWMYZj0pgGajaIV
        Pi5qqyyuB2exD40aI+6H6Bnnf
X-Received: by 2002:a05:6000:1786:b0:22e:41c0:cb0e with SMTP id e6-20020a056000178600b0022e41c0cb0emr974663wrg.93.1666079641497;
        Tue, 18 Oct 2022 00:54:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4zbEN1VWW5iyDyFlTL54Vj/S6lme9Dhmd2db+wdC7mCyjq8sDbKAtOPQjqQ/X/o6d2/KTT9g==
X-Received: by 2002:a05:6000:1786:b0:22e:41c0:cb0e with SMTP id e6-20020a056000178600b0022e41c0cb0emr974652wrg.93.1666079641211;
        Tue, 18 Oct 2022 00:54:01 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003a2f2bb72d5sm25026573wmp.45.2022.10.18.00.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 00:54:00 -0700 (PDT)
Message-ID: <7f576eb4-f8a6-53e0-17e9-285ecf03418c@redhat.com>
Date:   Tue, 18 Oct 2022 09:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: not ok 1 - single_pixel_source_buffer: The buggy address belongs
 to the physical page
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>
References: <CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CA+G9fYsuc9G+RO81E=vHMqxYStsmLURLdOB0NF26kJ1=K8pRZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding a few folks to Cc list that might help with this issue]

Hello Naresh,

Thanks a lot for your report.

On 10/18/22 08:40, Naresh Kamboju wrote:
> Following kunit tests started failing on Linux mainline.
>  - drm_format_helper_test — FAIL
>  - drm_test_fb_xrgb8888_to_xrgb2101010 — FAIL
>  - single_pixel_source_buffer — FAIL
> 
> Good: v6.0-3015-g2bca25eaeba6
> Bad: v6.0-5118-g833477fce7a1
>

Could you please let me know how you are running this? I tried to reproduce it
on v6.1-rc1 with the following command but all tests passed:

./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests/.kunitconfig --arch=x86_64
[09:41:53] Configuring KUnit Kernel ...                                                                                
[09:41:53] Building KUnit Kernel ...                                                                                   
Populating config with:                                                                                                
$ make ARCH=x86_64 O=.kunit olddefconfig                                                                               
Building with:                                                                                                         
$ make ARCH=x86_64 O=.kunit --jobs=8                                                                                   
[09:45:51] Starting KUnit Kernel (1/1)...                                                                              
[09:45:51] ============================================================                                                
Running tests with:                                                                                                    
$ qemu-system-x86_64 -nodefaults -m 1024 -kernel .kunit/arch/x86/boot/bzImage -append 'kunit.enable=1 console=ttyS0 kunit_shutdown=reboot' -no-reboot -nographic -serial stdio
...
[09:47:40] Testing complete. Ran 195 tests: passed: 195                                                                
[09:47:40] Elapsed time: 347.817s total, 0.003s configuring, 238.009s building, 109.771s running
 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> [   50.320990]         # Subtest: drm_test_fb_xrgb8888_to_xrgb2101010
> [   50.322059] ==================================================================
> [   50.326436] BUG: KASAN: slab-out-of-bounds in
> drm_test_fb_xrgb8888_to_xrgb2101010+0x2dd/0x520
> [   50.329249] Read of size 4 at addr ffff888104d7a5cc by task
> kunit_try_catch/619
> [   50.331596]
> [   50.332135] CPU: 1 PID: 619 Comm: kunit_try_catch Tainted: G    B
>          N 6.0.0 #1
> [   50.333876] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.12.0-1 04/01/2014
> [   50.335138] Call Trace:
> [   50.335531]  <TASK>
> [   50.335879]  dump_stack_lvl+0x49/0x62
> [   50.336462]  print_report.cold+0x5e/0x5d9
> [   50.337069]  ? _raw_spin_unlock_irqrestore+0x33/0x60
> [   50.337820]  ? update_kunit_status+0xee/0x160
> [   50.338494]  ? drm_test_fb_xrgb8888_to_xrgb2101010+0x2dd/0x520
> [   50.339354]  kasan_report+0xaa/0x130
> [   50.339905]  ? drm_fb_xrgb8888_to_xrgb2101010+0xa0/0xd0
> [   50.340680]  ? drm_test_fb_xrgb8888_to_xrgb2101010+0x2dd/0x520
> [   50.341576]  __asan_load4+0x80/0xa0
> [   50.342112]  drm_test_fb_xrgb8888_to_xrgb2101010+0x2dd/0x520
> [   50.342958]  ? drm_test_fb_xrgb8888_to_gray8+0x470/0x470
> [   50.343778]  ? update_load_avg+0x80/0xb80
> [   50.344407]  ? update_cfs_group+0x22/0x160
> [   50.345036]  ? load_balance+0x14d0/0x14d0
> [   50.345652]  ? dequeue_entity+0x1f2/0x6a0
> [   50.346263]  ? rcu_qs+0x1c/0x120
> [   50.346773]  ? finish_task_switch.isra.0+0xe0/0x410
> [   50.347532]  ? __kasan_check_write+0x14/0x20
> [   50.348192]  ? _raw_spin_lock_irqsave+0x9e/0x100
> [   50.348891]  ? _raw_spin_unlock_irqrestore+0x28/0x60
> [   50.349625]  ? trace_preempt_on+0x2a/0xf0
> [   50.350242]  ? __kthread_parkme+0x4f/0xd0
> [   50.350857]  kunit_try_run_case+0x91/0xd0
> [   50.351479]  ? kunit_catch_run_case+0x80/0x80
> [   50.352151]  ? kunit_try_catch_throw+0x40/0x40
> [   50.352897]  kunit_generic_run_threadfn_adapter+0x2f/0x50
> [   50.353890]  kthread+0x179/0x1b0
> [   50.354410]  ? kthread_complete_and_exit+0x30/0x30
> [   50.355126]  ret_from_fork+0x22/0x30
> [   50.355708]  </TASK>
> [   50.356047]
> [   50.356284] Allocated by task 619:
> [   50.356817]  kasan_save_stack+0x26/0x50
> [   50.357410]  __kasan_kmalloc+0xae/0xe0
> [   50.357980]  __kmalloc+0x1cf/0x390
> [   50.358501]  kunit_kmalloc_array_init+0x4b/0x80
> [   50.359189]  __kunit_add_resource+0x67/0x100
> [   50.359859]  kunit_kmalloc_array+0xf8/0x170
> [   50.360490]  drm_test_fb_xrgb8888_to_xrgb2101010+0x19f/0x520
> [   50.361341]  kunit_try_run_case+0x91/0xd0
> [   50.361948]  kunit_generic_run_threadfn_adapter+0x2f/0x50
> [   50.362747]  kthread+0x179/0x1b0
> [   50.363230]  ret_from_fork+0x22/0x30
> [   50.363779]
> [   50.364015] The buggy address belongs to the object at ffff888104d7a5c8
> [   50.364015]  which belongs to the cache kmalloc-8 of size 8
> [   50.365824] The buggy address is located 4 bytes inside of
> [   50.365824]  8-byte region [ffff888104d7a5c8, ffff888104d7a5d0)
> [   50.367485]
> [   50.367736] The buggy address belongs to the physical page:
> [   50.368579] page:000000003c09c153 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x104d7a
> [   50.369991] flags: 0x200000000000200(slab|node=0|zone=2)
> [   50.370804] raw: 0200000000000200 0000000000000000 dead000000000122
> ffff888100042280
> [   50.371933] raw: 0000000000000000 0000000080660066 00000001ffffffff
> 0000000000000000
> [   50.373021] page dumped because: kasan: bad access detected
> [   50.373958]
> [   50.374202] Memory state around the buggy address:
> [   50.374935]  ffff888104d7a480: fc fb fc fc fc fc fb fc fc fc fc fb
> fc fc fc fc
> [   50.376019]  ffff888104d7a500: fb fc fc fc fc fb fc fc fc fc fb fc
> fc fc fc fb
> [   50.377098] >ffff888104d7a580: fc fc fc fc fa fc fc fc fc 04 fc fc
> fc fc fa fc
> [   50.378174]                                               ^
> [   50.379025]  ffff888104d7a600: fc fc fc fa fc fc fc fc fa fc fc fc
> fc fa fc fc
> [   50.380123]  ffff888104d7a680: fc fc 00 fc fc fc fc fa fc fc fc fc
> fa fc fc fc
> [   50.381191] ==================================================================
> [   50.382461]         not ok 1 - single_pixel_source_buffer
> [   50.382909]         ok 2 - single_pixel_clip_rectangle
> [   50.384319]         ok 3 - well_known_colors
> [   50.385393]         ok 4 - destination_pitch
> [   50.386029]     # drm_test_fb_xrgb8888_to_xrgb2101010: pass:3
> fail:1 skip:0 total:4
> [   50.386657]     not ok 5 - drm_test_fb_xrgb8888_to_xrgb2101010
> [   50.387762] # drm_format_helper_test: pass:4 fail:1 skip:0 total:5
> [   50.388598] # Totals: pass:19 fail:1 skip:0 total:20
> [   50.389467] not ok 33 - drm_format_helper_test
> 
> Test log link,
> https://lkft.validation.linaro.org/scheduler/job/5633513#L7056
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.0-5118-g833477fce7a1/testrun/12273332/suite/kunit/tests/
> 
> Test results comparison:
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.1-rc1/testrun/12468488/suite/kunit/test/drm_format_helper_test/history/?page=2
> 
> For your reference:
> https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.0-3015-g2bca25eaeba6/testrun/12237941/suite/kunit/tests/
> 
> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
>   git_sha: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
>   git_describe: v6.0-5118-g833477fce7a1
>   kernel_version: 6.0.0
>   kernel-config: https://builds.tuxbuild.com/2FjJ6bdUwO43y6QWMJyjklBN9Ji/config
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/659360852
>   artifact-location: https://builds.tuxbuild.com/2FjJ6bdUwO43y6QWMJyjklBN9Ji
>   toolchain: gcc-11
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

