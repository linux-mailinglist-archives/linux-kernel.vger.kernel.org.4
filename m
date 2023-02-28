Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A186A609D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjB1UsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjB1UsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:48:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B538CDFE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:48:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bv17so11140657wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5pSFuXte4Put+OGlaihe6aCZ9w2PByb0dl9crZMPbc=;
        b=DFV7ahfEfzFoV2dGe2O8b29a9BHcSn9aNr4zH/PeMOCu/vAb0jRa3AV2i6UfMZhYY3
         mw9fhIfinpXbiTKAoGrZ0VJlyy9EXwJ6zoZHzoybXSnFINqDdXu4O7VFDMyRXgwqMwrt
         XSGBx7n/K7siMT30MYTpvnNwhULxQadMoK6UG8Ew3Mu4zFGsm6oar0SXwqaXpqCo4VwZ
         jmZvwZ5W83gWoQN4srERESWvRjFDGflE1WCVi3+p6qEzp4O3BXKxgC2IX3ratETWS04L
         ddb/JKapd0RUjiYRbbgq7NGpEhu8WRwOC7fvKWkwR4oMUWgxo7vxMzOZFwSfRjUCz3up
         nq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5pSFuXte4Put+OGlaihe6aCZ9w2PByb0dl9crZMPbc=;
        b=p/saJBacPLm4aGVMuC/30Dndh5g674l+MpZ7Gltmw3hgoXKLfRzxFZYgdWap5tfLR2
         Lcol5tkYK6wh8eGt63ovTJSqe9hGMApYrFWlXfSZIHvDyjtBNakQNZ1oLbkHq6bvCa5u
         ICVaQNkgBEZwq1Qf+VEORCW+dICZP73EpZef4nU+5+6GxgedXOjQDqPAJmZzCDK40CPE
         wlsXreJuWVn4/HZ1Wnmsj70EY+cwpz4AUmjrH3AW5oEM5TTK+m2itj9OnGC4jL206d7j
         RFE6aqe8ILSqgbOxdaZ+le9zyxkhsIPex4lV1EmcDllHorzx/SadcWVd0qebx74Rpwjs
         gFOA==
X-Gm-Message-State: AO0yUKV+bavdJ1JQLSDuwZcpECWqKVwfj4YYUwyfx8nWSLHku2Xm8a96
        JHfoQ4XvRKJxNas2ulBPffc=
X-Google-Smtp-Source: AK7set8n2sjowTK/0Tyuh5EcTat7vfS69gJQ0AFSJfR3hhBvHF4OTnziaEf2mbbS3vRsxHP2fCLm0g==
X-Received: by 2002:adf:f0d1:0:b0:2c8:3def:36dc with SMTP id x17-20020adff0d1000000b002c83def36dcmr2949359wro.17.1677617286351;
        Tue, 28 Feb 2023 12:48:06 -0800 (PST)
Received: from solpc.. (67.pool90-171-92.dynamic.orange.es. [90.171.92.67])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d5704000000b002c559843748sm10814692wrv.10.2023.02.28.12.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:48:05 -0800 (PST)
From:   Joan Bruguera <joanbrugueram@gmail.com>
To:     joanbrugueram@gmail.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH] bpf, x86: Fix IP after emitting call depth accounting
Date:   Tue, 28 Feb 2023 20:47:46 +0000
Message-Id: <20230228204746.12568-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230107051456.8800-1-joanbrugueram@gmail.com>
References: <20230107051456.8800-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

This should fix booting with `retbleed=stuff` on the defaults of various
distros using systemd, e.g. Fedora Rawhide, Arch Linux.

Wrt. Arch Linux, it has picked the patch up,
see https://bugs.archlinux.org/task/77601
