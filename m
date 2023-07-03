Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EA674574D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGCIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCIZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:25:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A291FB2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:25:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so59655e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 01:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688372752; x=1690964752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp3fp1qSItiz/81j1Jn0Y8MmMEZQA55BLYUlwg/+odc=;
        b=yk2kmk3giv6AbVNYYmuOrSSV4ibY/DiCDzMFp6kkVVmyHJB/VgRqhSO2IHEsthpn+Z
         w0T32K3+/LrjO46wkWn/GlXUjcDlNKnNFudXIw8avOiz3YFQ5RG4EkrH2z/gPBGQD4QK
         +5OMT/V366rvNA3Z9nO4qm0rhpSnp20TbxHeAKbFa4zoLdNGLbffUoW0Yb79mMb29DZ5
         dCrigVVqTB5sKkl4oL4sedGs2h+sqO2r1exAnyrAxNenrqJn7+pml0/SgosMN5KD5iDV
         ELHb+6fqm0I48+KeTzV3lk8z8wuI0aahka+5tQXlUpUSjwW1OPd/scHDcWHBg4TqiCET
         IUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688372752; x=1690964752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp3fp1qSItiz/81j1Jn0Y8MmMEZQA55BLYUlwg/+odc=;
        b=a/B9ZtNoXpVyNUDKB6lXBSvuKzT1fuEzInpx5wxn97T8yE13DuLOlQvY+v1nN4NrJs
         mKoVkXovrbtwVyP5wsKF36OhlX1UZ6V+kQfcQ/7HXEMkXTTVYDeChXYaFQGUHC2gGe74
         KVoXJ2CP6DjqcwAnG87zljcXZK3BKXP+EtjPQufbJV+17ffhTSHfjx1m4+heZXxnhSg+
         L0wUueD9y3S060IeJX58EoFCN9XZCdt9JtX+ft5svZsxUQD0PP+7OffmntKqBxhveEsm
         GMNC6gidZIIQ5Pzp+J3Fr2xL2v78LgIYctTvSlkVpryfOTEgZqUeowrYQ5hvfRRmpKLj
         pXuQ==
X-Gm-Message-State: ABy/qLbj88tpsjdhSXSdnsZLwCjONyxLljnm3y5K2E8VfTFODXSzm9Uk
        DlECZQDQKOF/ciXt8JzF8agPM3tPh5ij+VUGfGp8VtFbnKqbysEg2Y0QEw==
X-Google-Smtp-Source: APBJJlFBYWOLhrjQUwd+7EicrNp4kb6xDnv4wVbLgv4t0PscUrrTuqeYRl4SjoUM0MPqsLDIIkvD3dHia9umBOL2GoE=
X-Received: by 2002:a05:600c:8518:b0:3f6:f4b:d4a6 with SMTP id
 gw24-20020a05600c851800b003f60f4bd4a6mr114174wmb.7.1688372752025; Mon, 03 Jul
 2023 01:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-richten-ehren-5a4c9b042a23@brauner> <000000000000b359eb05ff9094f0@google.com>
In-Reply-To: <000000000000b359eb05ff9094f0@google.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Mon, 3 Jul 2023 10:25:40 +0200
Message-ID: <CANp29Y7n1pmATF7Qeu7AnXOiidnSnOF5X8SY5af4x=CViDmfDg@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] bpf-next test error: UBSAN:
 array-index-out-of-bounds in alloc_pid
To:     syzbot <syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: net-next test error: UBSAN: array-index-out-of-bounds in alloc_pi=
d

On Mon, Jul 3, 2023 at 10:02=E2=80=AFAM syzbot
<syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com> wrote:
>
> > On Mon, Jul 03, 2023 at 12:14:17AM -0700, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    c20f9cef725b Merge branch 'libbpf: add netfilter link =
atta..
> >> git tree:       bpf-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D127adbfb28=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D924167e366=
6ff54c
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D319a9b09e5de=
1ecae1e1
> >> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bin=
utils for Debian) 2.35.2
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/bf9c9608a1e0/=
disk-c20f9cef.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/3bde4e994bd0/vml=
inux-c20f9cef.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/5d80f863418=
3/bzImage-c20f9cef.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+319a9b09e5de1ecae1e1@syzkaller.appspotmail.com
> >
> > #syz dup: [syzbot] [kernel?] net-next test error: UBSAN: array-index-ou=
t-of-bounds in alloc_pid
>
> can't find the dup bug
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/000000000000b359eb05ff9094f0%40google.com.
