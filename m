Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1176629002
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbiKOCj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiKOCjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:39:52 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65D5186FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:39:50 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id j24so3712268vkk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1ILTLeSMxgFOFYM9RS8PdJS37F5lvZ1iFvgruZkKiw=;
        b=lWTNSz8xaLONgdkbQ6Bb4Jq8MGdM6ij5fedeH+eCH8WbmB5cbR2aegkK30xHMTfRGt
         EbC4rSFn3LLphRRGOnY8dNL6pY0uBC7Cu5HzfgnrZJtnjJoHtfGebPxvh3y3xqvM7bP4
         6NXFyB/NaRWDV3+3+/PfEjxECY2YsHH7WBkmfwllqiSNYeBqy9amEWmxg25dhQrM36YS
         W9c45iVdVJVQ+9cAwLcY6PvWTe3mrjtCA+7Iz7cFs4wkspbgpk3zSYgA7s5e84RoEY+X
         QnKbqUQRU2QO1tD2GCVq87S5ZAz5HR01QLWamO8hWrhEzpnAcXXXnCF/kAlAmFxiNVDh
         ROVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1ILTLeSMxgFOFYM9RS8PdJS37F5lvZ1iFvgruZkKiw=;
        b=MqW3JyHWC4/1mHvoYhV2jWq1auudHBXufSZcJPEAKYfgMfXi8ou6qm4ZpKndpLp1uR
         QIK55sxmY6Qx/NikCXbKhii2SRssKWkzfaSoL4/AF0ZbYBq2AmMLlbcACBqeWegg51Bs
         7wSZMNLVrNzvCmb82P6YK08P/z+JcxPDqKtnApd2jnmfYIkiHWBv30+l8cUwJYHfdBOx
         KTln9rNiIPcrlU+aI2wDECxiqms/FnGX0tOCdMVz0uP2EG8tGBLpJzKdTtzKc+PguRz2
         /DLPCDFMVwsx+cj40NpAwfX1HtLBV2lfrpu6W8hYuGYKQvN7zreZ1mii5NtmTEU/b2VY
         oBGA==
X-Gm-Message-State: ANoB5pnmeVh1nBOMvK8HbzdTCFhahHQ1HOuG2j8OfYYBDeYMjug/HljR
        rRgTu+J2Bfcg1uuj3nd2ouhdkHvzKo0u1pEb7RFw2FCBbaLyfFD5
X-Google-Smtp-Source: AA0mqf63sxUDmzFDWQceSy2VwcaVZj+HIKL+M0oYESaMu6wV/LbA0xTTT1QtN8WyfD+cwKIETqnewClSbZY62CXmYPI=
X-Received: by 2002:a05:6122:ca9:b0:3b8:7575:c871 with SMTP id
 ba41-20020a0561220ca900b003b87575c871mr8121650vkb.8.1668479926124; Mon, 14
 Nov 2022 18:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20221102160236.11696-1-iecedge@gmail.com> <20221114122255.72588f45@gandalf.local.home>
In-Reply-To: <20221114122255.72588f45@gandalf.local.home>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Tue, 15 Nov 2022 10:38:34 +0800
Message-ID: <CAFA-uR8TakkW=KoA_9RXcyw00Zj8+nNn2erSZ4Y9ULNM8ne11g@mail.gmail.com>
Subject: Re: [PATCH] tracepoint: Allow livepatch module add trace event
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     alison.schofield@intel.com, davidgow@google.com,
        thunder.leizhen@huawei.com, jianlv@ebay.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 1:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed,  2 Nov 2022 16:02:36 +0000
> Jianlin Lv <iecedge@gmail.com> wrote:
>
> > In the case of keeping the system running, the preferred method for
> > tracing the kernel is dynamic tracing (kprobe), but the drawback of
> > this method is that events are lost, especially when tracing packages
> > in the network stack.
>
> I'm not against this change, but the above is where I'm a bit confused. H=
ow
> are events more likely to be lost with kprobes over a static event?

We have encountered a case of kprobes missing event, detailed
information can refer to the following link:
https://github.com/iovisor/bcc/issues/4198

Replacing kprobe with =E2=80=99bpf + raw tracepoint=E2=80=98,  no missing e=
vents occur.

> -- Steve
