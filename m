Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663FB6CCE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjC1X7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1X67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:58:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3060B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:58:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso2801454pjf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 16:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680047882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxg9UcxnBkXt8zgQA8h1dey02WhDNKaLar+ys3qm8dQ=;
        b=NkVxnlsK8lUUJZs1kS/1W5QVPOjFuTrJz+ubfWnZLueEPSKzbgRmpQOXQ63v/rtgF3
         oeAStTFJ4Gexud6yXYaI058AUU/KUyQR50skQ4Szk48sCM5YmdF1zwzZZQGzz573cKrv
         kEsweuYlTG2qFWu/TcKNcCtMCZEN7hN4se6Cjn5w0SMaELLafDJBsRza0NYxCfy6Kd4f
         v6VmC9uqyL0nYoVjN7mOsNX3T0I+ijNNzPLyPTE4x+kKAppDiaENpZ6mcQFNYYEqni9I
         IY5kFsL0glzYoOTublc6eCCS1EXRocnoBYrYF3BPVtKIkCxfVmiI0FQ7iK2qcdQZLTu4
         nGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680047882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qxg9UcxnBkXt8zgQA8h1dey02WhDNKaLar+ys3qm8dQ=;
        b=mGjLYHzQRYUTADC/+CUzVbsMM5NnJt/kOmRHj+S88YV6Y9QSt1lzWZViByVgdu4lsl
         nIXK0d/dYSG/94kfYBJsTHeUAJIcsJUE3NpKfVy+EzlqCRz61T5XTo+/yK7qFbzXNgGo
         UAURDF7U7w9v5Nut0w0/028EfmicxM4AqRy3oAr95XweRGx8HdfxV1voL+tbvnxB7gbA
         H47Irbgm406eMty3qECE2iWW3RpoZq3AumwEk0AZVaweiqVOYMKs2iSmyCFCHpt1W6CK
         jXL7ESDCH+EVpjbU4uI2U/iUkiV5JTXuf1ph9attPifjfWPJlHX0xS3vyg70ycIcpx+0
         5WkA==
X-Gm-Message-State: AAQBX9dSUvWJGciFjqKEraSm8AIfoD5oDx7NTaaKxDignIRf11HRca4b
        MzjjRZPxt9Nsfo9RJcqccxXxtES5ns5Mpt95CPfMig==
X-Google-Smtp-Source: AKy350a5ZNaV4HDlL+ccwTX47jrVaOI6gMPdBOH0OIkahBQLQrdsPDnWhfTOUJINbZUa6UvJg9zDJ0GLT3+r7Pd3/Pg=
X-Received: by 2002:a17:902:6b44:b0:1a2:6e4d:7832 with SMTP id
 g4-20020a1709026b4400b001a26e4d7832mr213883plt.1.1680047882169; Tue, 28 Mar
 2023 16:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110353.853385546@infradead.org>
In-Reply-To: <20230328110353.853385546@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 28 Mar 2023 16:57:49 -0700
Message-ID: <CABk29Nt-9MufWcyxr8=ghHDj_kUj21vkEw=4X10NpXncxN32uQ@mail.gmail.com>
Subject: Re: [PATCH 04/17] sched/fair: Add avg_vruntime
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 4:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
[...]
> +/*
> + * Compute virtual time from the per-task service numbers:
> + *
> + * Fair schedulers conserve lag: \Sum lag_i =3D 0
> + *
> + * lag_i =3D S - s_i =3D w_i * (V - v_i)
> + *
> + * \Sum lag_i =3D 0 -> \Sum w_i * (V - v_i) =3D V * \Sum w_i - \Sum w_i =
* v_i =3D 0

Small note: I think it would be helpful to label these symbols
somewhere :) Weight  and vruntime are fairly obvious, but I don't
think 'S' and 'V' are as clear. Are these non-virtual ideal service
time, and average vruntime, respectively?
