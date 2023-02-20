Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A942F69C611
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjBTHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBTHkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:40:19 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D9FF36;
        Sun, 19 Feb 2023 23:40:17 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pU0mQ-0003aA-Rp; Mon, 20 Feb 2023 08:40:10 +0100
Message-ID: <8489afbb-2391-c22f-41fc-21726f09e444@leemhuis.info>
Date:   Mon, 20 Feb 2023 08:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: scsi: Recent kernels drop into emergency shell
Content-Language: en-US, de-DE
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, hare@suse.de, hch@lst.de, ming.lei@redhat.com,
        sumanesh.samanta@broadcom.com, michael.christie@oracle.com,
        john.garry@huawei.com, johannes.thumshirn@wdc.com, axboe@kernel.dk,
        osandov@fb.com, kashyap.desai@broadcom.com,
        gregkh@linuxfoundation.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230220061559.GJ159593@linux.vnet.ibm.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230220061559.GJ159593@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676878817;102b9f98;
X-HE-SMSGID: 1pU0mQ-0003aA-Rp
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 20.02.23 07:15, Srikar Dronamraju wrote:
> On a freshly installed system, booting latest upstream kernels causes the
> system to drop into emergency shell. The reason for dropping into emergency
> shell is system is unable to mount /home partition.

What kind of storage hardware do you have? Is this maybe related to this
fix, that afaics never was merged?
https://lore.kernel.org/all/20220928181350.9948-1-leeman.duncan@gmail.com/

Anyway for the rest of this mail:

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

> The system was able to boot properly on v5.18 kernel, but failed to boot
> v5.19 and 6.2-rc8 kernels.
> 
> On the recent or failing kernels, I see the below msg when kernel drops into
> emergency shell.
> 
> lvm[1370]: /dev/sda3 excluded: device is not in devices file.
> lvm[1370]: WARNING: no autoactivation for /dev/sda3: system.devices naa.60050768108001b3a800000000000097 current missing device id.
> systemd[1]: dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device: Job dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device/start timed out.
> systemd[1]: Timed out waiting for device /dev/mapper/rhel_ltcden3--lp9-home.
> systemd[1]: Dependency failed for /home.
> systemd[1]: Dependency failed for Local File Systems.
> systemd[1]: Dependency failed for Mark the need to relabel after reboot.
> systemd[1]: selinux-autorelabel-mark.service: Job selinux-autorelabel-mark.service/start failed with result 'dependency'.
> systemd[1]: local-fs.target: Job local-fs.target/start failed with result 'dependency'.
> systemd[1]: local-fs.target: Triggering OnFailure= dependencies.
> systemd[1]: home.mount: Job home.mount/start failed with result 'dependency'.
> systemd[1]: dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device: Job dev-mapper-rhel_ltcden3\x2d\x2dlp9\x2dhome.device/start failed with result 'timeout'.
> 
> lsblk o/p when system has fallen into ememrgency shell (aka bad kernel)
> NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> sda                          8:0    0  100G  0 disk
> â”œâ”€sda1                       8:1    0    4M  0 part
> â”œâ”€sda2                       8:2    0    1G  0 part /boot
> â””â”€sda3                       8:3    0   99G  0 part
>   â”œâ”€rhel_ltcden3--lp9-root 253:0    0 63.8G  0 lvm  /
>   â””â”€rhel_ltcden3--lp9-swap 253:1    0    4G  0 lvm  [SWAP]
> sr0                         11:0    1 1024M  0 rom
> 
> lsblk o/p when system boots normally on v5.18 or earlier kernels
> NAME                       MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> sda                          8:0    0  100G  0 disk
> â”œâ”€sda1                       8:1    0    4M  0 part
> â”œâ”€sda2                       8:2    0    1G  0 part /boot
> â””â”€sda3                       8:3    0   99G  0 part
>   â”œâ”€rhel_ltcden3--lp9-root 253:0    0 63.8G  0 lvm  /
>   â”œâ”€rhel_ltcden3--lp9-swap 253:1    0    4G  0 lvm  [SWAP]
>   â””â”€rhel_ltcden3--lp9-home 253:2    0 31.2G  0 lvm  /home
> sr0                         11:0    1 1024M  0 rom
> 
> 
> lvdisplay o/p when system has fallen into emergency shell (aka bad kernel)
>   Devices file sys_wwid naa.60050768108001b3a800000000000097 PVID iws5FZqBFBVE12w874dFuppLWkQUyEcb last seen on /dev/sda3 not found.
> 
> lvdisplay o/p when system boots normally on v5.18 or earlier kernels
>   --- Logical volume ---
>   LV Path                /dev/rhel_ltcden3-lp9/swap
>   LV Name                swap
>   VG Name                rhel_ltcden3-lp9
>   LV UUID                pzxuKG-ofVC-7jBY-HXn9-RDPN-G3hP-K5gdcI
>   LV Write Access        read/write
>   LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:21 +0530
>   LV Status              available
>   # open                 2
>   LV Size                <4.01 GiB
>   Current LE             1026
>   Segments               1
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           253:1
> 
>   --- Logical volume ---
>   LV Path                /dev/rhel_ltcden3-lp9/home
>   LV Name                home
>   VG Name                rhel_ltcden3-lp9
>   LV UUID                XDcVN6-kP6V-0LtL-nLM4-rvLv-gMQm-uaDRwi
>   LV Write Access        read/write
>   LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:26 +0530
>   LV Status              available
>   # open                 1
>   LV Size                31.16 GiB
>   Current LE             7977
>   Segments               1
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           253:2
> 
>   --- Logical volume ---
>   LV Path                /dev/rhel_ltcden3-lp9/root
>   LV Name                root
>   VG Name                rhel_ltcden3-lp9
>   LV UUID                sJlMVf-eE2v-UKJp-Esqg-uxis-wA1Y-gOXFnO
>   LV Write Access        read/write
>   LV Creation host, time ltcden3-lp9, 2023-01-24 09:44:36 +0530
>   LV Status              available
>   # open                 1
>   LV Size                63.82 GiB
>   Current LE             16339
>   Segments               1
>   Allocation             inherit
>   Read ahead sectors     auto
>   - currently set to     256
>   Block device           253:0
> 
> git bisect start '--'
> # bad: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
> git bisect bad 3d7cb6b04c3f3115719235cc6866b10326de34cd
> # good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
> git bisect good 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> # bad: [c011dd537ffe47462051930413fed07dbdc80313] Merge tag 'arm-soc-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect bad c011dd537ffe47462051930413fed07dbdc80313
> # good: [7e062cda7d90543ac8c7700fc7c5527d0c0f22ad] Merge tag 'net-next-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect good 7e062cda7d90543ac8c7700fc7c5527d0c0f22ad
> # good: [f8122500a039abeabfff41b0ad8b6a2c94c1107d] Merge branch 'etnaviv/next' of https://git.pengutronix.de/git/lst/linux into drm-next
> git bisect good f8122500a039abeabfff41b0ad8b6a2c94c1107d
> # good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
> git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
> # good: [f7a344468105ef8c54086dfdc800e6f5a8417d3e] ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()
> git bisect good f7a344468105ef8c54086dfdc800e6f5a8417d3e
> # bad: [fbe86daca0ba878b04fa241b85e26e54d17d4229] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> git bisect bad fbe86daca0ba878b04fa241b85e26e54d17d4229
> # bad: [f304d35e59958ea4be399f78e5be08d4a0c4db75] scsi: mpi3mr: Update driver version to 8.0.0.69.0
> git bisect bad f304d35e59958ea4be399f78e5be08d4a0c4db75
> # good: [21c2e3418d07955c7b87fc3f75688cb1c2b04a32] scsi: ufs: Remove the TRUE and FALSE definitions
> git bisect good 21c2e3418d07955c7b87fc3f75688cb1c2b04a32
> # good: [671a52f2aeafe2f42bddb53dcfe3933b1f641843] scsi: fnic: Remove unneeded flush_workqueue()
> git bisect good 671a52f2aeafe2f42bddb53dcfe3933b1f641843
> # bad: [d657700ccac71da19a4d1a591fafcd598ce0dd6e] scsi: core: Do not truncate INQUIRY data on modern devices
> git bisect bad d657700ccac71da19a4d1a591fafcd598ce0dd6e
> # good: [c5acd61dbb32b6bda0f3a354108f2b8dcb788985] scsi: megaraid: Fix error check return value of register_chrdev()
> git bisect good c5acd61dbb32b6bda0f3a354108f2b8dcb788985
> # good: [dc1178767cba9d67f5100fb370670fd613319362] scsi: mpt3sas: Use cached ATA Information VPD page
> git bisect good dc1178767cba9d67f5100fb370670fd613319362
> # bad: [e17d63403076affccd72d195f93bbf3f39514005] scsi: core: Pick suitable allocation length in scsi_report_opcode()
> git bisect bad e17d63403076affccd72d195f93bbf3f39514005
> # bad: [c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b] scsi: core: Query VPD size before getting full page
> git bisect bad c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b
> # first bad commit: [c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b] scsi: core: Query VPD size before getting full page
> 
> Commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> went in between v5.18 and v5.19.
> 
> Verifications:
> I have verified that reverting the said bad commit on top of v6.2-rc8, v5.19
> and on top of c92a6b5d63359dd6d2ce6ea88ecd8e31dd769f6b causes the system to
> boot normally.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced c92a6b5d63359dd
#regzbot title scsi: storage not properly detected
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
