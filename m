Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09B6F230D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjD2FWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 01:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjD2FWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:22:17 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B91A2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:22:15 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-44048c2de31so410271e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682745734; x=1685337734;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bL/dpwMYQ+vEeDJh/Rbu38HonyhpYys4O+gm1zm6TY=;
        b=iQIRR+WUkJPs58KirlB8yUSlotLvYchqufx+XnkW6X/1FZsyQ9VHmlhEKONBTY0mbf
         KFR8o3m1ulZ84JUo39burzd1qJRVEHqkWevz/r5jPooHKZRxgfY2uuoC4ILfk4hu6yRs
         GXtC0EfL+Md2ZmOc20ECdx701a24b92SqpI3rQCslrF1Z47/ZnsPKjKPAwf4oWuwYqbg
         rrGlkuzHpA1uu6ivyF9npb6EtgxZ2cY7XLbY7lftEl7DLEarpOhROXzoSHxs0Z4NaRb4
         upcpG7+UGifUvnTnpPJyR7baVjdvna1yLsdghW2+Xcvfb439HVtrNXYSt8q6Nh43RL4j
         H4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682745734; x=1685337734;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bL/dpwMYQ+vEeDJh/Rbu38HonyhpYys4O+gm1zm6TY=;
        b=CYppzZYNDlivGl2yZYCvI5ctLzfl/u13E7ZZPfdvL/8B5hnrSIXJogQ90cWWnyZaHv
         OywTrZ7RFBOdf99WuE+xT7s17SoaVP96ezjQ4UUQqqnfY3TOw1SJWCq2wbaFHdNpXQT7
         maq6CyR4yysHfph4j4GLl5AqArin9u4+COIBntEq5sD46FOTJFTH35kiwljLGl9OFPSg
         2R/ANVO3JK+NiagJE5xvt+PwNrjkDip/t1oZdN/0dSo+K6AELTLxIPfvdsePpD8Nwg0S
         8yKpYQiOsP3bIijw4pyn+wn6btoZbh3CW/Yyro+bwVH/5ehS1K3iFTZB66sh6kkHB72B
         F1ng==
X-Gm-Message-State: AC+VfDyr+gYJriK4Ux26hRKfazdtZsh3junHW1GoWRmTpBvnxMd+krkw
        7VtvAQZNyxFEfvZAclhkRMp1a9SmBsLRVO09FkHZN1ATrNI=
X-Google-Smtp-Source: ACHHUZ44lN8MK5H8S6Tcxa3Qc0+kiKMk6xhY9HuOmKfrNMNcBBHffbh880pltK8T6LwSBHfIy/9EmP1A/URpdtZcxSc=
X-Received: by 2002:a1f:41c9:0:b0:43f:ec5d:51e1 with SMTP id
 o192-20020a1f41c9000000b0043fec5d51e1mr3519478vka.9.1682745734332; Fri, 28
 Apr 2023 22:22:14 -0700 (PDT)
MIME-Version: 1.0
References: CAAJw_Zs3OBi4Rsb-Lp_mMihn=99nFYaHrRdp7KU8g2baCPdfbQ@mail.gmail.com <20230429020951.082353595@lindbergh.monkeyblade.net>
In-Reply-To: <20230429020951.082353595@lindbergh.monkeyblade.net>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sat, 29 Apr 2023 13:22:03 +0800
Message-ID: <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
Subject: iwlwifi broken in post-linux-6.3.0 after April 26
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can't start wifi on latest linux git pull ... started happening 3 days ago ...

Is there a fix for this? Or shall I bisect? Wifi works by reverting
back to released 6.3.0.

Thanks,
Jeff


# wpa_supplicant -Dnl80211 -c wpa.conf -iwlan0
wlwifi 0000:00:14.3: Failed to send RFI config cmd -5
iwlwifi 0000:00:14.3: LED command failed: -5
iwlwifi 0000:00:14.3: Failed to send MAC_CONFIG_CMD (action:1): -5

# lsmod
iwlmvm                352256  0
mac80211              610304  1 iwlmvm
iwlwifi               299008  1 iwlmvm
cfg80211              417792  3 iwlmvm,iwlwifi,mac80211
ax88179_178a           28672  0

# dmesg
iwlwifi 0000:00:14.3: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 6
iwlwifi 0000:00:14.3: Loaded firmware version: 78.3bfdc55f.0
so-a0-gf-a0-78.ucode
iwlwifi 0000:00:14.3: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
iwlwifi 0000:00:14.3: 0x000002F0 | trm_hw_status0
iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
iwlwifi 0000:00:14.3: 0x004DB13C | branchlink2
iwlwifi 0000:00:14.3: 0x004D0D3A | interruptlink1
iwlwifi 0000:00:14.3: 0x004D0D3A | interruptlink2
iwlwifi 0000:00:14.3: 0x000157FE | data1
iwlwifi 0000:00:14.3: 0x00000010 | data2
iwlwifi 0000:00:14.3: 0x00000000 | data3
iwlwifi 0000:00:14.3: 0x00000000 | beacon time
iwlwifi 0000:00:14.3: 0x0002A2E7 | tsf low
iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
iwlwifi 0000:00:14.3: 0x00000000 | time gp1
iwlwifi 0000:00:14.3: 0x0003E5C3 | time gp2
iwlwifi 0000:00:14.3: 0x00000001 | uCode revision type
iwlwifi 0000:00:14.3: 0x0000004E | uCode version major
iwlwifi 0000:00:14.3: 0x3BFDC55F | uCode version minor
iwlwifi 0000:00:14.3: 0x00000370 | hw version
iwlwifi 0000:00:14.3: 0x00480002 | board version
iwlwifi 0000:00:14.3: 0x80B0FF00 | hcmd
iwlwifi 0000:00:14.3: 0x00020000 | isr0
iwlwifi 0000:00:14.3: 0x20000000 | isr1
iwlwifi 0000:00:14.3: 0x58F00002 | isr2
iwlwifi 0000:00:14.3: 0x00C3000C | isr3
iwlwifi 0000:00:14.3: 0x00000000 | isr4
iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
iwlwifi 0000:00:14.3: 0x000157FE | wait_event
iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
iwlwifi 0000:00:14.3: 0x00000018 | lmpm_pmg_sel
iwlwifi 0000:00:14.3: 0x00000000 | timestamp
iwlwifi 0000:00:14.3: 0x0000103C | flow_handler
iwlwifi 0000:00:14.3: Start IWL Error Log Dump:
iwlwifi 0000:00:14.3: Transport status: 0x0000004B, valid: 7
iwlwifi 0000:00:14.3: 0x201002FD | ADVANCED_SYSASSERT
iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
iwlwifi 0000:00:14.3: 0x8046E300 | umac branchlink2
iwlwifi 0000:00:14.3: 0xC008191A | umac interruptlink1
iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
iwlwifi 0000:00:14.3: 0x0017020B | umac data1
iwlwifi 0000:00:14.3: 0x00000308 | umac data2
iwlwifi 0000:00:14.3: 0x00000304 | umac data3
iwlwifi 0000:00:14.3: 0x0000004E | umac major
iwlwifi 0000:00:14.3: 0x3BFDC55F | umac minor
iwlwifi 0000:00:14.3: 0x0003E5BE | frame pointer
iwlwifi 0000:00:14.3: 0xC0886C24 | stack pointer
iwlwifi 0000:00:14.3: 0x0017020B | last host cmd
iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
iwlwifi 0000:00:14.3: IML/ROM dump:
iwlwifi 0000:00:14.3: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:00:14.3: 0x000081CD | IML/ROM data1
iwlwifi 0000:00:14.3: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:00:14.3: Fseq Registers:
iwlwifi 0000:00:14.3: 0x60000100 | FSEQ_ERROR_CODE
iwlwifi 0000:00:14.3: 0x003E0003 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:00:14.3: 0x00190003 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:00:14.3: 0x0000A652 | FSEQ_OTP_VERSION
iwlwifi 0000:00:14.3: 0x00000003 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:00:14.3: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:00:14.3: 0x00080400 | FSEQ_CNVI_ID
iwlwifi 0000:00:14.3: 0x00400410 | FSEQ_CNVR_ID
iwlwifi 0000:00:14.3: 0x00080400 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x00400410 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:00:14.3: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:00:14.3: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xd05c18
iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd05c1c
iwlwifi 0000:00:14.3: Starting mac, retry will be triggered anyway
iwlwifi 0000:00:14.3: FW error in SYNC CMD RFI_CONFIG_CMD
CPU: 6 PID: 22193 Comm: wpa_supplicant Tainted: G     U             6.3.0 #1
Hardware name: LENOVO 21CCS1GL00/21CCS1GL00, BIOS N3AET72W (1.37 ) 03/02/2023
Call Trace:
 <TASK>
 dump_stack_lvl+0x33/0x50
 iwl_trans_txq_send_hcmd+0x33a/0x380 [iwlwifi]
 ? destroy_sched_domains_rcu+0x20/0x20
 iwl_trans_send_cmd+0x55/0xe0 [iwlwifi]
 iwl_mvm_send_cmd+0xd/0x30 [iwlmvm]
 iwl_rfi_send_config_cmd+0x8f/0xf0 [iwlmvm]
 iwl_mvm_up+0x8c9/0x980 [iwlmvm]
 __iwl_mvm_mac_start+0x181/0x1e0 [iwlmvm]
 iwl_mvm_mac_start+0x3f/0x100 [iwlmvm]
 drv_start+0x2c/0x50 [mac80211]
 ieee80211_do_open+0x2f2/0x6b0 [mac80211]
 ieee80211_open+0x62/0x80 [mac80211]
 __dev_open+0xca/0x170
 __dev_change_flags+0x1a1/0x210
 dev_change_flags+0x1c/0x60
 devinet_ioctl+0x555/0x790
 inet_ioctl+0x116/0x1b0
 ? netdev_name_node_lookup_rcu+0x58/0x70
 ? dev_get_by_name_rcu+0x5/0x10
 ? netdev_name_node_lookup_rcu+0x58/0x70
 ? dev_get_by_name_rcu+0x5/0x10
 ? dev_ioctl+0x34d/0x4c0
 sock_do_ioctl+0x3a/0xe0
 sock_ioctl+0x15a/0x2b0
 ? __sys_recvmsg+0x51/0xa0
 __x64_sys_ioctl+0x7d/0xa0
 do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7efcee3a0448
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24
d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89
c0 3d 00 f0 ff ff 77 0e 44 89 c0 c3 66 2e 0f 1f 84 00 00 00
RSP: 002b:00007ffe400ff678 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007efcee3a0448
RDX: 00007ffe400ff680 RSI: 0000000000008914 RDI: 0000000000000007
RBP: 0000000000000007 R08: 0000000000000000 R09: 000000000078f4b0
R10: e324395ae363498e R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000790a30 R14: 0000000000000002 R15: 0000000000000000
 </TASK>
