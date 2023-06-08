Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69E8727505
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjFHCeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjFHCeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:34:10 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADCC1FFA;
        Wed,  7 Jun 2023 19:34:09 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6262d8688baso1459576d6.1;
        Wed, 07 Jun 2023 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686191648; x=1688783648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP40DkHZE8fMAP8vvdgFF2kWzyMWQZR4DZPduOdwDWQ=;
        b=G0obPoIN8utqPXiuq/+nMv0epDlB1dzGm/vjM7bcGwptd1Jn6kyG8HWxD9YXpN/cm+
         mSb8p2kzKNMz8QvIXEZPRHGcz+pppRanKsWlAHMS6uoiT4FAal411F5XIqwbNnGvUP71
         lEHnsSlMV2ICiGwkrAiKFiKTnD5BTQAvfeeG1786OX8MSW60LUkgZVqfqvY0M8AxfxFS
         DSGJx7uM8VBV4knFc1yBhpt7p63HCkykjLpiaCVYcB60l+iO9F8XNQv5G58PF1fcsJhw
         2Rx9nmvOmRgdBrs82YierCWnRBLm+xii0qax286v7BLUVt8ay3El2nCuyAUX13ko5Fm2
         HIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686191648; x=1688783648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP40DkHZE8fMAP8vvdgFF2kWzyMWQZR4DZPduOdwDWQ=;
        b=g+gTczFlTXmxv6Hm+p+c8lctszVNq/Z1vtjHh2+fZdSWGhWd6fIdP/PzjqFUc5mhSO
         fhNH+TdLiN3bRFVx6l9fE4rOycPTG0dlVOtABiYwDhnn1MkEKW+pD9aHeNQ9Dfg/RbO2
         MS+/WISiuZUonRsdAa+hm1uXaUXKI5mxR5I+IyaQWWTXMU8qyt+kKqRaPwQMCVKH/KEW
         yB17wrECl3pypKBGZtn2dKlV/EOEvGxW0re5soypzclF5HsgLz+8YIbLr9Oc+PfprMNv
         5R+l3d/qSUg/ITxQDoTCkvu59RLXSQZ+xltLAh5CHVxmHxhIMfbq8w1gA1F2GdRERPMo
         ntDw==
X-Gm-Message-State: AC+VfDyz+oz0tjLdXhaXCTcBT3ajRmRHlsJY9kyLSuUky8fCz4ZMOzKM
        ZB8Z9I5jflH3CqL5QKzwDZN8L92CxdApRMCLjCs=
X-Google-Smtp-Source: ACHHUZ5gPVxw/28i5FilUmnhbMAE2AV8ykYXtiYaqW0G3GBqN7vSor/zNpBGMX/7DPaEu6m3yvv4BbB4Ws/Z3to+T9o=
X-Received: by 2002:a05:6214:1c4b:b0:5f1:606b:a9c8 with SMTP id
 if11-20020a0562141c4b00b005f1606ba9c8mr262744qvb.22.1686191648232; Wed, 07
 Jun 2023 19:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230606233613.1290819-1-aquini@redhat.com>
In-Reply-To: <20230606233613.1290819-1-aquini@redhat.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 8 Jun 2023 10:33:31 +0800
Message-ID: <CALOAHbD5ZWaXudkxsb4FWshfX0HEXNXa7zARXWa5BFPUXRmhxA@mail.gmail.com>
Subject: Re: [PATCH] writeback: fix dereferencing NULL mapping->host on writeback_page_template
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org,
        Aristeu Rozanski <aris@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 7:37=E2=80=AFAM Rafael Aquini <aquini@redhat.com> wr=
ote:
>
> When commit 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for
> wait_on_page_writeback()") repurposed the writeback_dirty_page trace even=
t
> as a template to create its new wait_on_page_writeback trace event, it
> ended up opening a window to NULL pointer dereference crashes due to
> the (infrequent) occurrence of a race where an access to a page in the
> swap-cache happens concurrently with the moment this page is being
> written to disk and the tracepoint is enabled:
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000040
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 800000010ec0a067 P4D 800000010ec0a067 PUD 102353067 PMD 0
>     Oops: 0000 [#1] PREEMPT SMP PTI
>     CPU: 1 PID: 1320 Comm: shmem-worker Kdump: loaded Not tainted 6.4.0-r=
c5+ #13
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-2023030=
1gitf80f052277c8-1.fc37 03/01/2023
>     RIP: 0010:trace_event_raw_event_writeback_folio_template+0x76/0xf0
>     Code: 4d 85 e4 74 5c 49 8b 3c 24 e8 06 98 ee ff 48 89 c7 e8 9e 8b ee =
ff ba 20 00 00 00 48 89 ef 48 89 c6 e8 fe d4 1a 00 49 8b 04 24 <48> 8b 40 4=
0 48 89 43 28 49 8b 45 20 48 89 e7 48 89 43 30 e8 a2 4d
>     RSP: 0000:ffffaad580b6fb60 EFLAGS: 00010246
>     RAX: 0000000000000000 RBX: ffff90e38035c01c RCX: 0000000000000000
>     RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff90e38035c044
>     RBP: ffff90e38035c024 R08: 0000000000000002 R09: 0000000000000006
>     R10: ffff90e38035c02e R11: 0000000000000020 R12: ffff90e380bac000
>     R13: ffffe3a7456d9200 R14: 0000000000001b81 R15: ffffe3a7456d9200
>     FS:  00007f2e4e8a15c0(0000) GS:ffff90e3fbc80000(0000) knlGS:000000000=
0000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 0000000000000040 CR3: 00000001150c6003 CR4: 0000000000170ee0
>     Call Trace:
>      <TASK>
>      ? __die+0x20/0x70
>      ? page_fault_oops+0x76/0x170
>      ? kernelmode_fixup_or_oops+0x84/0x110
>      ? exc_page_fault+0x65/0x150
>      ? asm_exc_page_fault+0x22/0x30
>      ? trace_event_raw_event_writeback_folio_template+0x76/0xf0
>      folio_wait_writeback+0x6b/0x80
>      shmem_swapin_folio+0x24a/0x500
>      ? filemap_get_entry+0xe3/0x140
>      shmem_get_folio_gfp+0x36e/0x7c0
>      ? find_busiest_group+0x43/0x1a0
>      shmem_fault+0x76/0x2a0
>      ? __update_load_avg_cfs_rq+0x281/0x2f0
>      __do_fault+0x33/0x130
>      do_read_fault+0x118/0x160
>      do_pte_missing+0x1ed/0x2a0
>      __handle_mm_fault+0x566/0x630
>      handle_mm_fault+0x91/0x210
>      do_user_addr_fault+0x22c/0x740
>      exc_page_fault+0x65/0x150
>      asm_exc_page_fault+0x22/0x30
>
> This problem arises from the fact that the repurposed writeback_dirty_pag=
e
> trace event code was written assuming that every pointer to mapping
> (struct address_space) would come from a file-mapped page-cache object,
> thus mapping->host would always be populated, and that was a valid case
> before commit 19343b5bdd16. The swap-cache address space (swapper_spaces)=
,
> however, doesn't populate its ->host (struct inode) pointer, thus leading
> to the crashes in the corner-case aforementioned.
>
> commit 19343b5bdd16 ended up breaking the assignment of __entry->name and
> __entry->ino for the wait_on_page_writeback tracepoint -- both dependent
> on mapping->host carrying a pointer to a valid inode. The assignment of
> __entry->name was fixed by commit 68f23b89067f ("memcg: fix a crash in
> wb_workfn when a device disappears"), and this commit fixes the remaining
> case, for __entry->ino.
>
> Fixes: 19343b5bdd16 ("mm/page-writeback: introduce tracepoint for wait_on=
_page_writeback()")
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Thanks for your fix!
Reviewed-by: Yafang Shao <laoar.shao@gmail.com>

> ---
>  include/trace/events/writeback.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writ=
eback.h
> index 86b2a82da546..54e353c9f919 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>                 strscpy_pad(__entry->name,
>                             bdi_dev_name(mapping ? inode_to_bdi(mapping->=
host) :
>                                          NULL), 32);
> -               __entry->ino =3D mapping ? mapping->host->i_ino : 0;
> +               __entry->ino =3D (mapping && mapping->host) ? mapping->ho=
st->i_ino : 0;
>                 __entry->index =3D folio->index;
>         ),
>
> --
> 2.39.2
>


--=20
Regards
Yafang
