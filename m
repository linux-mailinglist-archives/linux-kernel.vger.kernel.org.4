Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC55F6D70
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiJFSUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiJFSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 14:20:39 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E80696F8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 11:20:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-132e9bc5ff4so3117780fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 11:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvZZAbpP6BsRmYO8eDv4ALVmewEv2pB5Qkzc/cExC/c=;
        b=LrEjH2cWkq3csQCkPUASQkN9+IfYjOMJvwTATtoZz1Pey9Bh1q2Wem5Yxdo77vW1s3
         KNzlvLsPIYCLT9GWyJU6iZLu0fjuqCLSWONMRP65fryja4NUDXuaDcm4mILly16tcGC1
         E2fSpojOg8qHrBYMXiJgtQDxAH+RE/TguFFxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvZZAbpP6BsRmYO8eDv4ALVmewEv2pB5Qkzc/cExC/c=;
        b=t7CklJSYw/i/M7UXrOZeaSDEPYSkaYOcRwOd3A1DEDmveOqIBcdeTzksrmIq2LJOmC
         Qgq6WNc7hKV6Asns530gbgG54Td1PgMS1G4YUKjgQUMrO0UpcqIWp11XfVEpAcOw/uqn
         u9/nSdqUL4Rfhet38R1s4PPpUjR1WaWsh409DjD5WjscWJAUceZZm/rqco7w2BMBl4hj
         58K8brQUXHpsCWoIe4mE/cIR7h/BCC6tZog9efq16B6EXnGErxxIxmTTstu0K0J3SaIx
         yb42Ah988Zc6O43rYkwwcBvAkq46YK70g6i+9TYA+mHTk8RdqhfTUrdt2MFt9O5fH7Xl
         JsKQ==
X-Gm-Message-State: ACrzQf08SFoxLCQq+XDrb3xq3ghmtBNdIuG3IWtGU/FaUl3CiFXrkbM9
        HQCosyxXgtkpmUYpXW8cTyCTWnOXG2+DbQ==
X-Google-Smtp-Source: AMsMyM5P8dZ63P0EwfsMqjTMoI2kyr4UOj+ucD7WvPSDGRrCZpVAse8Yz7siPM1lSJw5Or5ctz50yg==
X-Received: by 2002:a05:6870:4286:b0:132:756f:6b97 with SMTP id y6-20020a056870428600b00132756f6b97mr575676oah.38.1665080437204;
        Thu, 06 Oct 2022 11:20:37 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id y31-20020a056870459f00b0010bf07976c9sm146782oao.41.2022.10.06.11.20.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:20:34 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so1981328oom.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 11:20:33 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr531643oti.176.1665080433520; Thu, 06
 Oct 2022 11:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
In-Reply-To: <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Oct 2022 11:20:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
Message-ID: <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     =?UTF-8?B?UGhpbCBDaGFuZyAo5by15LiW5YuzKQ==?= 
        <Phil.Chang@mediatek.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
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

On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Sorry but you need to get your driver mainline in order to support
> vmalloc interface.

Actually, I think even then we shouldn't support vmalloc - and
register_shm_helper() just needs to be changed to pass in an array of
actual page pointers instead.

At that point TEE_SHM_USER_MAPPED should also go away, because then
it's the caller that should just do either the user space page
pinning, or pass in the kernel page pointer.

JensW, is there some reason that wouldn't work?

                 Linus
