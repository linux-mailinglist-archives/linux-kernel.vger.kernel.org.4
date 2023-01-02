Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABE565B1A8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbjABL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjABL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:56:57 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65C2DF0;
        Mon,  2 Jan 2023 03:56:56 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 50919119FCEB;
        Mon,  2 Jan 2023 12:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1672660161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ajhGT9QUg+fbKi5W35a5UF/UZ/AD4ae8TaelrcZEChk=;
        b=psmkqCbUvHaHLoK0A2BOLekypB7LQEEptw3268Tf7MqJgJOg/mJaft8W9y8+V5+yVA0jVZ
        gqqxciVgmCjK1wl8L45I5ln8pPAp/J8k400EluhE0OTmu3lgTkLRyHJsHZJi3FkU1OjU8i
        y6fA4CPl/VXyq8WXpd4WsqklpQwv45U=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
Date:   Mon, 02 Jan 2023 12:49:19 +0100
Message-ID: <1842801.CQOukoFCf9@natalenko.name>
In-Reply-To: <8202004.NyiUUSuA9g@natalenko.name>
References: <8202004.NyiUUSuA9g@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On pond=C4=9Bl=C3=AD 2. ledna 2023 12:45:30 CET Oleksandr Natalenko wrote:
> This is a sudden splash I've got while just using my workstation:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
> Use-after-free read at 0x00000000e57c579c (in kfence-#173):
>  bfq_exit_icq_bfqq+0x132/0x270
>  bfq_exit_icq+0x5e/0x80
>  exit_io_context+0x88/0xb0
>  do_exit+0x66c/0xb80
>  kthread_exit+0x29/0x30
>  kthread+0xbd/0x110
>  ret_from_fork+0x22/0x30
>=20
> kfence-#173: 0x000000005d7be631-0x000000006ad0b684, size=3D568, cache=3Db=
fq_queue
> allocated by task 40147 on cpu 16 at 13975.114285s:
>  bfq_get_queue+0xdf/0x4e0
>  bfq_get_bfqq_handle_split+0x75/0x170
>  bfq_insert_requests+0x832/0x2580
>  blk_mq_sched_insert_requests+0x63/0x150
>  blk_mq_flush_plug_list+0x122/0x360
>  __blk_flush_plug+0x106/0x160
>  blk_finish_plug+0x29/0x40
>  dm_bufio_prefetch+0x108/0x4d0 [dm_bufio]
>  dm_tm_issue_prefetches+0x44/0x70 [dm_persistent_data]
>  dm_pool_issue_prefetches+0x39/0x43 [dm_thin_pool]
>  do_worker+0x4c/0xd60 [dm_thin_pool]
>  process_one_work+0x258/0x410
>  worker_thread+0x55/0x4c0
>  kthread+0xde/0x110
>  ret_from_fork+0x22/0x30
>=20
> freed by task 40147 on cpu 20 at 14500.096700s:
>  bfq_put_queue+0x185/0x2d0
>  bfq_exit_icq_bfqq+0x129/0x270
>  bfq_exit_icq+0x5e/0x80
>  exit_io_context+0x88/0xb0
>  do_exit+0x66c/0xb80
>  kthread_exit+0x29/0x30
>  kthread+0xbd/0x110
>  ret_from_fork+0x22/0x30
>=20
> CPU: 20 PID: 40147 Comm: kworker/dying Tainted: G        W          6.1.0=
=2Dpf2 #1 ff5dbde5ea280110a73397797e059b8558cda111
> Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 4304 12/12/=
2022
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I'm using v6.1.2, never experienced this before and cannot reproduce it a=
t will. This kernel does not have any extra patches for the block layer on =
top of v6.1.2.
>=20
> In case you know what's going on, please let me know.

I assume 246cf66e30 ("block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq") m=
ay have fixed the issue. This commit is pending for upcoming v6.1.3.

=2D-=20
Oleksandr Natalenko (post-factum)


