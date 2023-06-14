Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5699E72F9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbjFNJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbjFNJrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:47:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068D2956;
        Wed, 14 Jun 2023 02:46:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f9ac889629so7029911cf.0;
        Wed, 14 Jun 2023 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686736005; x=1689328005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EanIfS98KUe5yrtcjDQyAd1823WeZMizYVQsiGSPT5E=;
        b=K+RgZfynrPaP6KrPQURS/uEYhF2QkeD0z/B6obFnnJu/xbxV5AfjBN5L8F3iBFgWF9
         nPT8H3XE+lFMLbsWEyA6lXD2Ow5sgwXMP/Qda3K7WGrESD1aacQOzgWP/J2BpCSMeK54
         NfHX5bAoaWuO3/VyZVL4IS/wDjNMWruV01pX4wgF5j26ZSxoCNt6LQ3DFb3wgCWYwdZO
         X1I1StBv53FKixQWMtG02JPlqfEGllxK0AL0S+UnPR0DMCXUN3YCu+MLjWCMRaQsFdmc
         8f3nQId/DwI3b++JaZ4TizGSnCnuMvIt7C32g17ZhCNof+zMqPvIGxW1yLxxRNvn3yx0
         TeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686736005; x=1689328005;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EanIfS98KUe5yrtcjDQyAd1823WeZMizYVQsiGSPT5E=;
        b=gmtN5lFfqNAFdfXwrAXKiHhNONBpbiWQFnU5W800Tm5yRCS6Ng2by/5tTkG09G0dUX
         ABGod6TtARV5NRcQVAXjmO/U+0RLmO3CIHpKjA8Ltlek1spX6tgph49HimX86ozl/Oh0
         74yOefEDkWn8xF/1F9cmdPgOQkdl3DK9sYojaKK1+dypqVm6NTM4LIt+R8MisrM4HNuE
         OFfMWbRhxY9gaayjpfrFPVuD0dv/5MF/thN7fLAYiLZDzSgFzHRzaCyU9BN3BbbTicxh
         BjvB2rijH6u8nxFkiAcUTFxcgrEZO4Aae6XclgRyPPtyP/xKG/1psirYDRbT2W01X43j
         KLwA==
X-Gm-Message-State: AC+VfDzC4WllON2Hz1IHac1Do157XG08zunhebluxNZqh5gzvPag3N9c
        z4ByJ/rACy4Bdv9iftCKvfOyIpxHKKJVckqg+SA=
X-Google-Smtp-Source: ACHHUZ4ecmeXa74a5bJRWJMfBl8ejRAvzPt8ZrcWqxnEhgZZhx9HSLnKKAdj0+reXY6TkYbykdx6evy+K34j6nlJ7PY=
X-Received: by 2002:a05:6214:4115:b0:62f:1283:6185 with SMTP id
 kc21-20020a056214411500b0062f12836185mr2079064qvb.2.1686736005403; Wed, 14
 Jun 2023 02:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPR5MujgLpWm_Y4H7PptK7DJeCB+t0RjP6Fj4Umf0MmFg@mail.gmail.com>
In-Reply-To: <CABXGCsPR5MujgLpWm_Y4H7PptK7DJeCB+t0RjP6Fj4Umf0MmFg@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 14 Jun 2023 14:46:34 +0500
Message-ID: <CABXGCsPiK+f37TpvoYEJqez=uaMEZA2KzTbOkZyuPds+AshPww@mail.gmail.com>
Subject: Re: mt76 patchset cause KASAN: use-after-free in tasklet_action_common.isra.0+0x6a4
 when computer shutdown
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        ryder.lee@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Is there anything else I can help here?

On Thu, Jun 8, 2023 at 4:03=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
> After beginning the release cycle of the 6.4 kernel I noted that when
> I reboot or turn off the computer the last message which I see is a
> use-after-free bug found by kasan sanitizer.
> Here is photo: https://ibb.co/1fxMYjt
> Below photo transcripted to text form:
> [    87.946202]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    87.946247] BUG: KASAN: use-after-free in
> tasklet_action_common.isra.0+0x6a4/0x7a0
> [    87.9462811 Read of size 8 at addr ffff8882b46a6a88 by task ksoftirqd=
/2/29
> [    87.946306]
> [    87.946315] CPU: 2 PID: 29 Comm: ksoftirqd/2 Tainted: G        W
>  L    -------  ---
> 6.4.0-0.rc5.20230606gitf8dba31b0a82.42.fc39.x86_64+debug #1
> [    87.946359] Hardware name: Micro-Star International Co., Ltd.
> MS-7D73/MPG B650I EDGE WIFI (MS-7D73), BIOS 1.30 05/24/2023
> [    87.946396] Call Trace:
> [    87.946408]  <TASK>
> [    87.9464191  dump_stack_lvl+0x76/0xd0
> [    87.946439]  print_report+0xcf/0x670
> [    87.946459]  ? tasklet_action_common.isra.0+0x6a4/0x7a0
> [    87.946481]  ? tasklet action_common.isra.0+0x6a4/0x7a0
> [    87.946502]  kasan_report+0xa8/0xe0
> [    87.946531]  ? tasklet_action_common.isra.0+0x6a4/0x7a0
> [    87.946555]  tasklet_action_common.isra.0+0x6a4/0x7a0
> [    87.946577]  __do_softirq+0x218/0x8bb
> [    87.946596]  ? __pfx___do_softirq+0x10/0x10
> [    87.946614]  ? run_ksoftirqd+Ox73/0x80
> [    87.946633]  ? smpboot_thread_fn+0x5bc/0x9b0
> [    87.946651]  run_ksoftirqd+0x4b/0x80
> [    87.946668]  smpboot_thread_fn+0x5bc/0x9b0
> [    87.946687]  ? __pfx_smpboot_thread_fn+0x10/0x10
> [    87.946706]  kthread+0x2eb/0x3c0
> [    87.946722]  ? __pfx_kthread+0x10/0x10
> [    87.946740]  ret_from_fork+0x29/0x50
> [    87.946760]  </TASK>
> [    87.946771]
> [    87.946778] The buggy address belongs to the physical page:
> [    87.946799] page:000000008f30de24 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x2b46a6
> [    87.946833] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x=
1fffff)
> [    87.946857] page_type: Oxffffffff()
> [    87.946873] raw: 0017ffffc0000000 0000000000000000
> dead000000000122 0000000000000000
> [    87.946901] raw: 0000000000000000 0000000000000000
> 00000000ffffffff 0000000000000000
> [    87.946930] page dumped because: kasan: bad access detected
> [    87.946949] r8169 0000:0e:00.0 enp14s0: Link is Down
> [    87.946950]
> [    87.946968] Memory state around the buggy address:
> [    87.946970]  ffff8882b46a6980: ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff
> [    87.946971]  ffff8882b46a6a00: ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff
> [    87.946972] >ffff8882b46a6a80: ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff
> [    87.947093]                       ^
> [    87.947109]  ffff8882b46a6b00: ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff
> [    87.947134]  ffff8882b46a6b80: ff ff ff ff ff ff ff ff ff ff ff ff
> ff ff ff ff
> [    87.947158]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    87.947186] Disabling lock debugging due to kernel taint
>
> I suppose many users didn't notice it because all modern Linux distro
> use a plymouth screen which hides all kernel messages during boot and
> shutdown. And this bug message is not recording in journalctl, because
> at the stage when this message appears journalctl was already offline.
>
> I used git bisect for trying to find the problem commit:
> And answered:
> - "good" when the computer was finishing work without the
> use-after-free message.
> - "bad" every time when I saw use-after-free bug message.
> - "skip" when the computer was stucking at the shutdown.
> And I got such bisect log:
>
> git bisect start
> # status: waiting for both good and bad commits
> # good: [173ea743bf7a9eef04460e03b00ba267cc52aee2] Merge tag
> 'pull-nios2' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good 173ea743bf7a9eef04460e03b00ba267cc52aee2
> # status: waiting for bad commit, 1 good commit known
> # bad: [6e98b09da931a00bf4e0477d0fa52748bf28fcce] Merge tag
> 'net-next-6.4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
> git bisect bad 6e98b09da931a00bf4e0477d0fa52748bf28fcce
> # good: [2c96606a0f8b7900387dbeb6532b59527999834d] Merge tag
> 'gpio-updates-for-v6.4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
> git bisect good 2c96606a0f8b7900387dbeb6532b59527999834d
> # bad: [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag
> 'wireless-next-2023-04-21' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
> git bisect bad ca288965801572fe41386560d4e6c5cc0e5cc56d
> # good: [d56417ad1133fc41752bb9fe37da7ae3187395a4] net: phy: smsc:
> clear edpd_enable if interrupt mode is used
> git bisect good d56417ad1133fc41752bb9fe37da7ae3187395a4
> # good: [c54876cd5961ce0f8e74807f79a6739cd6b35ddf] net/sched: pass
> netlink extack to mqprio and taprio offload
> git bisect good c54876cd5961ce0f8e74807f79a6739cd6b35ddf
> # skip: [3288ee5844b74cebb94ed15bc9b5b9d3223ae038] Merge ath-next from
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> git bisect skip 3288ee5844b74cebb94ed15bc9b5b9d3223ae038
> # good: [b6d85cf5bd1433c5dd6bf6bb3a176537184c630c] net/ipv6:
> Initialise msg_control_is_user
> git bisect good b6d85cf5bd1433c5dd6bf6bb3a176537184c630c
> # skip: [d2a158d113cbfe37a5dd3f44dc96d008dd910a81] Merge tag
> 'mt76-for-kvalo-2023-04-18' of https://github.com/nbd168/wireless
> git bisect skip d2a158d113cbfe37a5dd3f44dc96d008dd910a81
> # good: [02461d9368c59510ef51cc8a1db1f0f31cfbf9ad] wifi: rtw88: main:
> Reserve 8 bytes of extra TX headroom for SDIO cards
> git bisect good 02461d9368c59510ef51cc8a1db1f0f31cfbf9ad
> # good: [827145392a4aad635b93e5235b7d7fecc2fa31c7] net: enetc: only
> commit preemptible TCs to hardware when MM TX is active
> git bisect good 827145392a4aad635b93e5235b7d7fecc2fa31c7
> # skip: [27db47ab1f47906c2392f9d246e244e412b19278] wifi: mt76: mt7996:
> enable mesh HW amsdu/de-amsdu support
> git bisect skip 27db47ab1f47906c2392f9d246e244e412b19278
> # good: [22b68fc6d693e7a2b1c0eb852463f4a72522fa08] wifi: iwlwifi: mvm:
> fix RFKILL report when driver is going down
> git bisect good 22b68fc6d693e7a2b1c0eb852463f4a72522fa08
> # good: [f94557154d9fc77c392844523388edd4661a27a3] wifi: wcn36xx: add
> support for pronto-v3
> git bisect good f94557154d9fc77c392844523388edd4661a27a3
> # good: [ccf73f6e69c0244a979e97eb6c38f80cd6cbc116] wifi: rtw88: add
> port switch for AP mode
> git bisect good ccf73f6e69c0244a979e97eb6c38f80cd6cbc116
> # good: [a6f187f92bcc2b17821538b4a11d61764e68b091] wifi: rtw88: usb:
> fix priority queue to endpoint mapping
> git bisect good a6f187f92bcc2b17821538b4a11d61764e68b091
> # skip: [61d1f54533496711e06fcfd42b93c5ded9e27c7a] wifi: mt76: move
> mcu_uni_event and mcu_reg_event in common code
> git bisect skip 61d1f54533496711e06fcfd42b93c5ded9e27c7a
> # good: [73175a042955e531ec355a8708585befa67a22db] sctp: delete the
> nested flexible array skip
> git bisect good 73175a042955e531ec355a8708585befa67a22db
> # good: [b9235aef84929e5330cb87125a6baf1cf7988983] wifi: ath12k:
> Remove redundant pci_clear_master
> git bisect good b9235aef84929e5330cb87125a6baf1cf7988983
> # good: [6257c702264c44d74c6b71f0c62a7665da2dc356] wifi: ath11k: fix
> tx status reporting in encap offload mode
> git bisect good 6257c702264c44d74c6b71f0c62a7665da2dc356
> # skip: [3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209] wifi: mt76: mt7996:
> fill txd by host driver
> git bisect skip 3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209
> # skip: [f4d63a87b527de258eec5bd6e9547f063d472b79] wifi: mt76: dma:
> use napi_build_skb
> git bisect skip f4d63a87b527de258eec5bd6e9547f063d472b79
> # skip: [09d4d6da1b65d09414e7bce61459593f3c80ead1] wifi: mt76:
> mt7921e: Set memory space enable in PCI_COMMAND if unset
> git bisect skip 09d4d6da1b65d09414e7bce61459593f3c80ead1
> # skip: [230a167e094770fdcc104481719ef7b1a706fb27] wifi: mt76: set
> NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 on supported drivers
> git bisect skip 230a167e094770fdcc104481719ef7b1a706fb27
> # good: [49ce92fbee0b6bb8066dddf37489483b3b6b5c25] pds_core: add FW
> update feature to devlink
> git bisect good 49ce92fbee0b6bb8066dddf37489483b3b6b5c25
> # skip: [12db28c3ef31f719bd18fa186a40bb152e6a527c] mt76: mt7921: fix
> kernel panic by accessing unallocated eeprom.data
> git bisect skip 12db28c3ef31f719bd18fa186a40bb152e6a527c
> # good: [45fd01f2fbf1119d083931b095ad6d0f13443d0e] net/mlx5e: Refactor
> duplicated code in mlx5e_ipsec_init_macs
> git bisect good 45fd01f2fbf1119d083931b095ad6d0f13443d0e
> # skip: [2631c5b6ef9d7c6707e020def6947464c8aa6f92] wifi: mt76: Replace
> zero-length array with flexible-array member
> git bisect skip 2631c5b6ef9d7c6707e020def6947464c8aa6f92
> # good: [64822bdba456a145f7cb4c66d9939bf42c64ae62] dt-bindings: mt76:
> add active-low property for led
> git bisect good 64822bdba456a145f7cb4c66d9939bf42c64ae62
> # skip: [6d6793cef6a491b8f6db5f40ef3334411293da32] wifi: mt76: mt7921:
> Replace fake flex-arrays with flexible-array members
> git bisect skip 6d6793cef6a491b8f6db5f40ef3334411293da32
> # skip: [3d78c46423c6567ed25ca033e086865b1b4d5ae1] wifi: mt76:
> mt7921e: stop chip reset worker in unregister hook
> git bisect skip 3d78c46423c6567ed25ca033e086865b1b4d5ae1
> # good: [b100722a777f6455d913666a376f81342b2cb995] wifi: ath11k:
> Remove disabling of 80+80 and 160 MHz
> git bisect good b100722a777f6455d913666a376f81342b2cb995
> # skip: [03eb52dd78cab08f13925aeec8315fbdbcba3253] wifi: mt76: mt7921:
> add Netgear AXE3000 (A8000) support
> git bisect skip 03eb52dd78cab08f13925aeec8315fbdbcba3253
> # good: [6a8b899df1562a46a8c55cebc7d35508a24300d3] wifi: mt76: add
> mt76_connac_gen_ppe_thresh utility routine
> git bisect good 6a8b899df1562a46a8c55cebc7d35508a24300d3
> # skip: [15ee62e73705df447971613de4fa660dd71ed40e] wifi: mt76: mt7996:
> enable BSS_CHANGED_BASIC_RATES support
> git bisect skip 15ee62e73705df447971613de4fa660dd71ed40e
> # skip: [5c47cdebbaeb7724df6f9f46917c93e53f791547] wifi: mt76: mt7921:
> fix missing unwind goto in `mt7921u_probe`
> git bisect skip 5c47cdebbaeb7724df6f9f46917c93e53f791547
> # good: [97c75e1adeda78b3794936c617d8b86e9ebd54f5] wifi: rtw88: set
> pkg_type correctly for specific rtw8821c variants
> git bisect good 97c75e1adeda78b3794936c617d8b86e9ebd54f5
> # good: [59a3a312009723e3e5082899655fdcc420e2b47a] wifi: rtw88: Fix
> memory leak in rtw88_usb
> git bisect good 59a3a312009723e3e5082899655fdcc420e2b47a
> # skip: [3d2892e05086d09aecf14ea64b2debbf495e313c] wifi: mt76: connac:
> fix txd multicast rate setting
> git bisect skip 3d2892e05086d09aecf14ea64b2debbf495e313c
> # good: [c2171b068beea766311e4c2858ef8497504c6e6d] wifi: mt76: mt7996:
> enable configured beacon tx rate
> git bisect good c2171b068beea766311e4c2858ef8497504c6e6d
> # good: [cd85c8b059c54b00e3b509e83fb36c2798f50128] wifi: rtl8xxxu: Add
> rtl8xxxu_write{8,16,32}_{set,clear}
> git bisect good cd85c8b059c54b00e3b509e83fb36c2798f50128
> # skip: [e12b2e99b8799f26432528934edc8677888ad72f] wifi: mt76: mt7615:
> increase eeprom size for mt7663
> git bisect skip e12b2e99b8799f26432528934edc8677888ad72f
> # good: [6c6d62ae8271bd4b55dd2ba4b7ed552162823880] wifi: rtw88: Update
> spelling in main.h
> git bisect good 6c6d62ae8271bd4b55dd2ba4b7ed552162823880
> # good: [dfc39d4026fb2432363c0f77543c4cf3adca4c7b] net/packet: support
> mergeable feature of virtio
> git bisect good dfc39d4026fb2432363c0f77543c4cf3adca4c7b
> # only skipped commits left to test
> # possible first bad commit:
> [ca288965801572fe41386560d4e6c5cc0e5cc56d] Merge tag
> 'wireless-next-2023-04-21' of
> git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next
> # possible first bad commit:
> [3288ee5844b74cebb94ed15bc9b5b9d3223ae038] Merge ath-next from
> git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
> # possible first bad commit:
> [d2a158d113cbfe37a5dd3f44dc96d008dd910a81] Merge tag
> 'mt76-for-kvalo-2023-04-18' of https://github.com/nbd168/wireless
> # possible first bad commit:
> [3b522cadedfe6e9e0e8193d7d4ab5aa8d0c73209] wifi: mt76: mt7996: fill
> txd by host driver
> # possible first bad commit:
> [230a167e094770fdcc104481719ef7b1a706fb27] wifi: mt76: set
> NL80211_EXT_FEATURE_CAN_REPLACE_PTK0 on supported drivers
> # possible first bad commit:
> [f4d63a87b527de258eec5bd6e9547f063d472b79] wifi: mt76: dma: use
> napi_build_skb
> # possible first bad commit:
> [e12b2e99b8799f26432528934edc8677888ad72f] wifi: mt76: mt7615:
> increase eeprom size for mt7663
> # possible first bad commit:
> [27db47ab1f47906c2392f9d246e244e412b19278] wifi: mt76: mt7996: enable
> mesh HW amsdu/de-amsdu support
>
> Unfortunately git bisect did not say which exact commit is culprit
> here, but anyway we got the result with eigh commits which can be
> reviewed.

--=20
Best Regards,
Mike Gavrilov.
