Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35877644C29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLFTD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLFTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:03:57 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415B72BB3B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 11:03:56 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id m4so7927840pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XKfLhtZZQiN5pSiAeJTX5xqJtW3KLq/JfbNtylyUaJU=;
        b=VxnAxNgGOgsXpsaU7ZA9OwLdwRP+hxmrx+La/sML6JnsAqnSN846KtCP7QFgZdJ7k2
         XrzPinRPiVGRjSDOVdRhfhxpGaUW+acW8edifKFVjXwabtoXz8j7/QRvhJBeKtbH1RC6
         WPtdttADxBJqD0yAtMP+Z9te/jOg+mvO9JSWk83VdxwdqKJTYfEwFFzh6AqH87cEIrhb
         SQcW32Jkn3X1pNwyNGSCZIui3qg+5J5d4i5ptIlRRZvPC1DUaxVbB46T6UO3kLSsAK/T
         Zxa3ub9vZcoxF0qKrtE5Kx2XSOvsuks6WIZul7fEtjeooWMb9ztBzipdeGp4t/fL1kFW
         YVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKfLhtZZQiN5pSiAeJTX5xqJtW3KLq/JfbNtylyUaJU=;
        b=jOk5uJ1aI9g4b9yQcKF3EQbcBYwnChMDDE27IbOU/S2o7rVaOv+/NvUPTvCGPHmbGW
         UvgGes+c0+jlIGWOG+9CEchCa8KnbevcHgaI35MPGv9NQ0pzxB0vMSTGn5S5AZ/UPjdO
         wabaXYUkE64iVB/W16s1IZyqKCihtn6Gu602X48L4akx0E98cxF+Y2eJcvbCx1TxJ1xt
         7Md862XLOiW90R/11ShSNPjRM7XDC2AbSmQ2cQqhiVIhPA/ojFZv31GPnyxQP5rwFUkg
         RBXde5pTOomQ0ETJ0OlTb1Fb9YlM8uf5Yod7b7Mc4szbMStmAN227rd0Y6a3wVYaDFNa
         FmwA==
X-Gm-Message-State: ANoB5plZLta7oHpndpuPWpopLNZddnitfZQoVrA8VMYAhWnjOUxw39Nb
        17yzc0owCW8PLgy9IK6Nn4TLJOfKuSnjJL8rAUINcw==
X-Google-Smtp-Source: AA0mqf5d3mlBVbzJKV3LClOVBUQgCRRqs0aWQXsM3lcVZ7urMWklFHSAKQKM1YAMovSKjvk0q/ONrVCIg3KZXXH1oQw=
X-Received: by 2002:a17:902:d346:b0:189:efa1:2953 with SMTP id
 l6-20020a170902d34600b00189efa12953mr2486379plk.97.1670353435620; Tue, 06 Dec
 2022 11:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20221115214036.1571015-1-sammler@google.com>
In-Reply-To: <20221115214036.1571015-1-sammler@google.com>
From:   Michael Sammler <sammler@google.com>
Date:   Tue, 6 Dec 2022 11:03:44 -0800
Message-ID: <CAFPP518x6cg97tK_Gm-qqj9htoydsBtYm5jbG_KivK5rfLcHtA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: populate numa information
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mina Almasry <almasrymina@google.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Sammler <mich.sammler@gmail.com>
Cc:     Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is reviewed and tested. Is there anything that needs to be
done from my side (e.g. sync with mainline)?

(Adding my alternative email address to this thread as I will soon
lose access to the address I am sending this email from.)
