Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE0621AA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiKHRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiKHRah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:30:37 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C6110C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:30:35 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-13c569e5ff5so17006098fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWo0wICwvqJmPXPuoTpa5Ov9X6wNIXJjhaYFsJ+BGYo=;
        b=inpZwFESW1ZamihaSqdrc9ChUddB6Fjv4GA30UUriCnKoWNZPua4c19i62HP0o9S2a
         qEWl1Tp7GsrnEFR1/5QI1MAS9CF6nX/bGHjx3Lk5QfR6EB6Q4YqdByIEx0PYn5SGa4F6
         qc1DldWyqPJs1pzLWEnAx3R6itk4Fxamd6ErGvU5koAuSn+3HgoI6MX7oPMDX7/w74tm
         UT6a8EYtym0NbjYnsulw9YHXuHNzcvyt9X9t4SPqvrzBwcXYI7p1KW53k1KjJJlm9K5j
         I8ZT1Pfs6P/hMgzIbRnAaI/9h9kNfTxXobMUivlUo2RcAV2ZL9egrsTRPtfB8LZiyNke
         cETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWo0wICwvqJmPXPuoTpa5Ov9X6wNIXJjhaYFsJ+BGYo=;
        b=u08x94juqamWiQN6r251gh7h/dZk/zzsbkBMvylRS6hmTfMLHTyQnga6E5wcut8wli
         szCqsTK0tfOjUOkmZ6S5C5ss4EOpw3mZf4WKdsBFvq1/JMDVlpPENaewHEI3ueUrY2bZ
         QrJNp1Ouwgd1ddaIHM2F6YrpsdLggXDCRlu3Ny66P0rcHYWRlvAtxsThcWhwfnJTlgZ1
         F1biYbCMcJf7O1Ry1uA1tqww1P8IGPmp2JwdT2K4zr4LAHJXMDRI3wT1l717VJ6R97zl
         iPG2g9IrYV04A6Zz3MrNienZL0xUiPF/8+obWCK+9heeR6EqyEUPwZ/T13GufZkg8EEL
         TqeQ==
X-Gm-Message-State: ACrzQf0p8MWWYgsF5VrGYJvK4GWhpZDHXPejGfC+LUMp6/No7T4edxRN
        ZKYf4/WJZ+D3e1nMinJNE5OXUZGiUuOo6Z7GF8WAzBOZfbdb2w==
X-Google-Smtp-Source: AMsMyM5PyRLrb7aHWWG0mjHPxLyk0Yjif/RFNPSHYipaQZ54lZuk3GTphB97+yjXW9cIHwHIwpFjeA/4v43I8HrXxPY=
X-Received: by 2002:a05:6870:3516:b0:13b:8bc3:1140 with SMTP id
 k22-20020a056870351600b0013b8bc31140mr42724335oah.293.1667928635061; Tue, 08
 Nov 2022 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com> <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
In-Reply-To: <Y2qJE2Bpbvnf5Ejb@kbusch-mbp>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 8 Nov 2022 09:30:23 -0800
Message-ID: <CA+HUmGijWOvmt_+UZyc8bArdOYMecDUbwpMiSBBjnfJsLx6ofg@mail.gmail.com>
Subject: Re: nvme: hung task in blk_mq_freeze_queue_wait
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 8:51 AM Keith Busch <kbusch@kernel.org> wrote:
> That is an old kernel, I think it'd be worth trying something newer to
> confirm if this observation isn't already fixed. Specifically, it looks
> like you have multiple namespaces timing out IO near simultaneously, and
> causing a mismatched handling. That kind of thing was fixed after the
> follow (plus some prior dependencies):
>
>   commit d6135c3a1ec0cddda7b8b8e1b5b4abeeafd98289
>   Author: Keith Busch <kbusch@kernel.org>
>   Date:   Tue May 14 14:46:09 2019 -0600
>
>       nvme-pci: Sync queues on reset


On Tue, Nov 8, 2022 at 3:29 AM Hillf Danton <hdanton@sina.com> wrote:
>
> Given blk_mq_freeze_queue_wait() in the call trace, another explanation
> may be percpu refcount [1], which can be tested with the diff attached.
>
> Only for thoughts.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/block/blk-mq.c?h=next-20221104#n228
>
> Hillf

Thanks Keith, Hillf, I will look into that.

Francesco
