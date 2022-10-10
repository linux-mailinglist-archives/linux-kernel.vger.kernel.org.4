Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0EE5FA2A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJJRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJJRUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:20:36 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF72424BED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:35 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1322d768ba7so13180398fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PkxAA/9uVoaYu8Fb5sQePdbAwJCyyv1sqzkKH/uTXFY=;
        b=BBkIy6D9LtVndEDq+Q3u4CWEzY2rLnypV7QWR5cA37JnOw3xlsUOmtEwLZdF+ckVQQ
         fq8/7esW895XTWVsuf7T8y/EHIBtxCz4BFFca+qYCw+oNLV8UY6QDQfhXpWCg3HpIpO/
         D9a1Q0kzkDXaGTf+g18WoTuftFtQUTTlseKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkxAA/9uVoaYu8Fb5sQePdbAwJCyyv1sqzkKH/uTXFY=;
        b=hG28hLk9P9owe029/YdFccAaUz5lyUqpW7Jqibk1o0hZqICwdL3G+furuaCr8ffQZh
         ptEaI69rC1lX92+9YRoVIBCuyIyCeuBli0i+1dzv37qg6BKNXi9dHvnUXhzgxGa9zQJM
         nDYMQDniioF1YAeE4mk1EEzW6Zi/SQMbKqZJxFm9LwZbvs8p0pd8iVKVcoDdu6nlurjQ
         7fO7j4HYV37WWEUUkyvAbRpejYVJq6czZOJybPuOE/wvgIgAdJGKPUhiWmJrKnNiWsrb
         Q0gHx20gmOQ4uP2MEAVmlIddwMBNPcf9+VTjB9C14dYWxMncoKluUDB38YOG4RiFEDem
         uo6g==
X-Gm-Message-State: ACrzQf2OPAOGQd9LN4vtwhzFPTNn9JX24Es3n9QZJSKTrisZW8SFU1Y5
        gAFbLLGrnFRdeqcdmFANGdNzALvfZAAwtw==
X-Google-Smtp-Source: AMsMyM6tqMPXAsnXnzD7i1Bu365b5nX/DxEy+wWgNpOmuFGVdK0fX2tO8M7/Tw9q7MKa0HRvN3VDBQ==
X-Received: by 2002:a05:6870:82a4:b0:132:eb87:37 with SMTP id q36-20020a05687082a400b00132eb870037mr13970181oae.13.1665422434297;
        Mon, 10 Oct 2022 10:20:34 -0700 (PDT)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com. [209.85.160.50])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056870d79200b0011f400edb17sm5525913oab.4.2022.10.10.10.20.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 10:20:32 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-136b5dd6655so1330170fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:20:32 -0700 (PDT)
X-Received: by 2002:a05:6870:c888:b0:12c:7f3b:d67d with SMTP id
 er8-20020a056870c88800b0012c7f3bd67dmr10619390oab.229.1665422431775; Mon, 10
 Oct 2022 10:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com> <20221010074234.GA20788@lst.de>
In-Reply-To: <20221010074234.GA20788@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Oct 2022 10:20:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>
Message-ID: <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        =?UTF-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> I suspect the best long term option would be to just pass an iov_iter..

Hmm. Yeah, that sounds like a workable model, and solves the problem
JensW pointed out with my simplistic "just pass a page array" approach
where you also need to keep track of how to release things.

                   Linus
