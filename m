Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B705FFB09
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJOPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJOPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:32:25 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F04A82C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:32:24 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ojj9C-0006Lu-5F; Sat, 15 Oct 2022 17:32:22 +0200
Message-ID: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
Date:   Sat, 15 Oct 2022 17:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US, de-DE
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <Y0Zw2eHEb1aZ9f4y@debian.me>
 <29362d2e-eec6-5a23-4354-cf8868d50b2c@alu.unizg.hr>
 <6375f31f-316a-bebc-6aec-c6241049e401@alu.unizg.hr>
 <7e0b733d-db73-f9a7-0965-4744e63f1a33@gmail.com>
 <951eb72c-09b5-1832-3852-fa25e423b840@alu.unizg.hr>
 <ddf13e46-c091-80b2-3b57-c43ac45435f0@alu.unizg.hr>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ddf13e46-c091-80b2-3b57-c43ac45435f0@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1665847944;37981f3a;
X-HE-SMSGID: 1ojj9C-0006Lu-5F
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Topposting, to make this easier to access for everyone.

@Mirsad, thx for bisecting.

@Phillip: if you want to see a problem description and the whole
backstory of the problem that apparently is caused by 	b09a7a036d20
("squashfs: support reading fragments in readahead call"), see this
thread (Mirsad sadly started a new one with the quoted mail below):
https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/

Ciao, Thorsten

On 15.10.22 16:56, Mirsad Goran Todorovac wrote:
> On 14. 10. 2022. 23:44, Mirsad Goran Todorovac wrote:
>> On 14. 10. 2022. 14:28, Bagas Sanjaya wrote:
>>> On 10/14/22 17:32, Mirsad Todorovac wrote:
>>>> I tried the "make localmodconfig" and provided the default answers
>>>> ([ENTER]) to all questions
>>>> the script asked as advised here:
>>>> https://www.stolaf.edu/people/rab/os/linux-compile.html .
>>>>
>>>> However, though it built much faster, the stripped version did not
>>>> trigger the bug.
>>>>
>>>> I am now trying to reproduce the bug with v6.0-rc[123] with
>>>> config-{051913,060000}.
>>>> This brings a lot of combinations, and though I am a newbie, I
>>>> noticed that build scripts
>>>> start with "make clean" for both deb-pkg and rpm-pkg.
>>>>
>>>> Is there a way to rebuild only the stuff that changed between the
>>>> versions?
>>>>
>>> You can try building kernel with ccache enabled. However, you'll need
>>> to unset build timestamp, since it will make builds non-deterministic:
>>>
>>>     make CC="ccache gcc" KBUILD_BUILD_TIMESTAMP=""
>>>
>>> The first ccache build will be slower than normal build, because the
>>> object files needs to be written twice (to the output directory and
>>> to the cache), though.
>>
>> Hi, Bagas,
>>
>> Unfortunately, the ccache command did not work as expected. It still
>> calls the gcc compiler proper,
>> even in the second run ...
>>
>> PID USER      PR  NI    VIRT    RES    SHR S %CPU  %MEM     TIME+ COMMAND
>> 29213 root      20   0   67420  55100  15676 R  98.1   0.3 0:02.42
>> /opt/alt/python38/bin/python3 /usr/bin/imunify360-agent rstatus
>> 29374 mtodorov  30  10  133932 110104  18408 R  98.1   0.7 0:01.46
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arc+
>>  1079 root      20   0  589008 371700   2320 S  97.1   2.3 2343:20
>> /usr/sbin/bacula-fd -f -c /etc/bacula/bacula-fd.conf
>> 29425 mtodorov  30  10   95052  71520  16700 R  76.9   0.4 0:00.80
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arc+
>> 29459 mtodorov  30  10   79268  51432  12732 R  46.2   0.3 0:00.48
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arc+
>> 29462 mtodorov  30  10   65516  34828   9224 R  43.3   0.2 0:00.45
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -E -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./+
>> 29505 mtodorov  30  10       0      0      0 R  32.7   0.0 0:00.34 [cc1]
>> 29506 mtodorov  30  10   65940  38560  12576 R  32.7   0.2 0:00.34
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./arc+
>> 29523 mtodorov  30  10   52180  21572   9344 R  17.3   0.1 0:00.18
>> /usr/lib/gcc/x86_64-linux-gnu/8/cc1 -E -quiet -nostdinc -I
>> ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I ./+
>>  5517 root      20   0  780956  77812  10052 S  11.5   0.5 466:39.30
>> /opt/alt/python38/bin/python3 -m im360.run
>> 29384 mtodorov  30  10    7132   3964   3568 S  11.5   0.0 0:00.12
>> /usr/local/bin/ccache gcc -Wp,-MMD,sound/i2c/other/.ak4114.o.d
>> -nostdinc -I./arch/x86/include -I./arch/x86/include/generated -I.+
>> 29407 mtodorov  30  10    7116   3748   3360 S  10.6   0.0 0:00.11
>> /usr/local/bin/ccache gcc -Wp,-MMD,fs/exfat/.nls.o.d -nostdinc
>> -I./arch/x86/include -I./arch/x86/include/generated -I./include -+
>> 29451 mtodorov  30  10    7132   3968   3568 S   9.6   0.0 0:00.10
>> /usr/local/bin/ccache gcc
>> -Wp,-MMD,drivers/pinctrl/intel/.pinctrl-tigerlake.o.d -nostdinc
>> -I./arch/x86/include -I./arch/x86/incl+
>> 29522 mtodorov  30  10    8288   7520   1468 R   8.7   0.0 0:00.09
>> scripts/genksyms/genksyms -r /dev/null
>> 29524 mtodorov  30  10   17008  12480   3204 R   4.8   0.1 0:00.05 as
>> -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I
>> ./arch/x86/include/uapi -I ./arch/x86/include/generated+
>>  8896 mtodorov  20   0   12212   4616   3348 R   3.8   0.0 0:04.58 top
>>
>> 29525 mtodorov  30  10   15028  10412 3248 R   3.8   0.1   0:00.04 as
>> -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I
>> ./arch/x86/include/uapi -I ./arch/x86/include/generated+
>>
>> I used the command line:
>> $ make CC="/usr/local/bin/ccache gcc" KBUILD_BUILD_TIMESTAMP="" -j10
>> deb-pkg
>>
>> I tried to install the latest ccache (version 4.6.3), but it silently
>> calls cc1, despite having 4GiB of cache in $HOME/.ccache ...
>>
>> I must be doing something wrong. Heavens are not aligned in favour to
>> me this day :-/
> 
> Here are the results of the requested bisect on the bug involving the
> Firefox snap build 104.x, 105.0.x, squashfs and which was manifested on
> both Ubuntu snap and with snapd in AlmaLinux 8.6 (CentOS fork):
> 
> mtodorov@domac:~/linux/kernel/linux_stable$ git bisect log
> git bisect start
> # bad: [568035b01cfb107af8d2e4bd2fb9aea22cf5b868] Linux 6.0-rc1
> git bisect bad 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> # good: [51dd976781da8c0b47e106ed59a96d7c28972ce4] Linux 5.19.15
> git bisect good 51dd976781da8c0b47e106ed59a96d7c28972ce4
> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
> # good: [b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1] Merge tag
> 'drm-next-2022-08-03' of git://anongit.freedesktop.org/drm/drm
> git bisect good b44f2fd87919b5ae6e1756d4c7ba2cbba22238e1
> # good: [6614a3c3164a5df2b54abb0b3559f51041cf705b] Merge tag
> 'mm-stable-2022-08-03' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect good 6614a3c3164a5df2b54abb0b3559f51041cf705b
> # bad: [eb5699ba31558bdb2cee6ebde3d0a68091e47dce] Merge tag
> 'mm-nonmm-stable-2022-08-06-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad eb5699ba31558bdb2cee6ebde3d0a68091e47dce
> # good: [24df5428ef9d1ca1edd54eca7eb667110f2dfae3] ALSA: hda/realtek:
> Add quirk for HP Spectre x360 15-eb0xxx
> git bisect good 24df5428ef9d1ca1edd54eca7eb667110f2dfae3
> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag
> 'dma-mapping-5.20-2022-08-06' of
> git://git.infradead.org/users/hch/dma-mapping
> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
> # good: [4cfa6ff24a9744ba484521c38bea613134fbfcb3] powerpc/64e: Fix
> kexec build error
> git bisect good 4cfa6ff24a9744ba484521c38bea613134fbfcb3
> # good: [24cb958695724ffb4488ef4f65892c0767bcd2f2] Merge tag
> 's390-5.20-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
> git bisect good 24cb958695724ffb4488ef4f65892c0767bcd2f2
> # good: [db98b43086275350294f5c6f797249b714d6316d] squashfs: always
> build "file direct" version of page actor
> git bisect good db98b43086275350294f5c6f797249b714d6316d
> # good: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8] video: fbdev: s3fb:
> Check the size of screen before memset_io()
> git bisect good 6ba592fa014f21f35a8ee8da4ca7b95a018f13e8
> # good: [b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6] Merge tag
> 'for-5.20/fbdev-1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> git bisect good b5a8466d37d30cfcc8015789f4a3f0c44b6c7bc6
> # bad: [97d3b2676fc6bc4865eb825037f4492f0fb804eb] ocfs2: remove some
> useless functions
> git bisect bad 97d3b2676fc6bc4865eb825037f4492f0fb804eb
> # bad: [591c32bddbe20ba0e172d9def3c7f22b9c926ad9] kernel/hung_task: fix
> address space of proc_dohung_task_timeout_secs
> git bisect bad 591c32bddbe20ba0e172d9def3c7f22b9c926ad9
> # bad: [b09a7a036d2035b14636cd4c4c69518d73770f65] squashfs: support
> reading fragments in readahead call
> git bisect bad b09a7a036d2035b14636cd4c4c69518d73770f65
> mtodorov@domac:~/linux/kernel/linux_stable$
> 
> The git bisect stopped at the squashfs commit
> b09a7a036d2035b14636cd4c4c69518d73770f65, so I included Phillip in Cc:,
> according to the Code of Conduct.
> 
> Have a nice day!
> 
> Kind regards,
> Mirsad
> 
> --
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu
> -- 
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> The European Union
> 

#regzbot ^backmonitor:
https://lore.kernel.org/all/b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr/
#regzbot introduced: b09a7a036d2035

