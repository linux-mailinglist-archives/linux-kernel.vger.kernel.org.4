Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A27681A19
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjA3TN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238300AbjA3TNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:13:52 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1762693;
        Mon, 30 Jan 2023 11:13:41 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id kt14so34836992ejc.3;
        Mon, 30 Jan 2023 11:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AF1ytHP8yIyD33XjERJjWJgeLd5sZmmY2qcXpld0hmk=;
        b=5jmcA5qsn70rwYYqHQOrS8fni7G/BkrUGTic11TJcA+1jkXm2kmH8Wrw1R1JGlJtWd
         hCpQjzs2jjTJOierD18/261C6c+9ei+hT0cBwBAfNnz7RdUx6KprPM8xgBySXU4GvHs9
         hPC/QXFQrc0nzgRagipdnycMOv9UECbWusGpm+4kgIydFoLKkDlJYDWDj0XOrlbpRCp3
         MNRnutLWlV1AzkLjGV9UgGGRadfmW76t2QGcvYLVFKyf9ObPrmxkuKjLZ1SdK5Gyx8SN
         Vj61k5BsHgdkJUFjD2mSJzB1ZgobKjNxBG5ohk8OamarZMT7dzYYipWiNsPNNsyo2SPQ
         PZVA==
X-Gm-Message-State: AFqh2kpsd5+BW0DiSttWqZGLH0MQ6qxA1LqTscaxyEDBIGrFw1qcAz7t
        y7HR1W6L1xWuc4KyVz5hE5hRDRZan+8CvcrpluTtxHDp4XM=
X-Google-Smtp-Source: AMrXdXtwgvtL34Ya4QUw4+O+GI4+Uu/LUQaoUd34IgcpjkCKRYATzrxmUKA8Gy/+7oCNRZTgtKKY5Zoz1L/NPpwYzTM=
X-Received: by 2002:a17:906:60c8:b0:877:612e:517e with SMTP id
 f8-20020a17090660c800b00877612e517emr7090384ejk.152.1675106019926; Mon, 30
 Jan 2023 11:13:39 -0800 (PST)
MIME-Version: 1.0
References: <1751684.VLH7GnMWUR@kreacher>
In-Reply-To: <1751684.VLH7GnMWUR@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Jan 2023 20:13:28 +0100
Message-ID: <CAJZ5v0jpmyBGFMhhKqGH6kfsuAGhhvqwbiM_Ck++_N9kUOav0Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] thermal: intel: intel_pch: Code simplification and cleanups
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 8:08 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This patch series removes some uneeded code and data structures from the
> intel_pch_thermal driver, rearranges it and does some assorted minor cleanups
> (no change in behavior should result from it).
>
> Please refer to the individual patch changelogs for details.

I forgot to mention that this series is applicable on top of

https://patchwork.kernel.org/project/linux-pm/patch/5641279.DvuYhMxLoT@kreacher/

which in turn applies on top of the current thermal branch in linux-pm.git,
that is also present in the linux-next branch in linux-pm.git.

Thanks!
