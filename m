Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9278F673B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjASOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjASOJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:09:14 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829D982D56;
        Thu, 19 Jan 2023 06:08:24 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id y8so1567612qvn.11;
        Thu, 19 Jan 2023 06:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lI7bNBM712aJHyLKJ5fyHPeJK8BWNRSC3RcpgvndO94=;
        b=KHtYoiEGDHvGcMAIId58pIH/ad712Vd1Ipc/s9+GUT72Bk5MszZ/aYutEJu4zAuVCu
         OFCTh5hVApxS6FTKAQaWZsjqmW37l5RoZ+Juat+KT05dMBkJHHH1Zy+HcP7nd9KVni8T
         fjpZWSFZ/epe9iIS/fOYd96JzirjpCrUHwLaD1xOh3D4HuEILxQEtGr0yIKKwoLizZ49
         9A3lIx2RODW7WnKBTl4jiJFvha0jVi0lys5EI+Y77zVlyaSZVtcsg+OYDXP4hAHQlSes
         c3aq/uLhTlNjanPmyp/41DZ4vyhxiq97KRceC9aqb2MssK8tL002ApEoMUEoLowi1QNK
         kQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lI7bNBM712aJHyLKJ5fyHPeJK8BWNRSC3RcpgvndO94=;
        b=n2qR8lbph1PkJPgSr2Kdy6vl6+liNYyAsYSXiOErxXH80Nb4IccCMHxaW4gbrSUjqJ
         z32C99pa8eQbFmNT+1x1B47KcX7TM+kNIL7glQ5NbO0XcZHTrGr2M168WlPKHNWh/C5B
         NQMQWQyrYEMYdItiDrDNt2KzKFfvd1fXOYyuiatAv2TZq3dyP+iU7b7xyo7soZCiWtHt
         l2wsTGFIh3k6U3iDzBXwQgTOtVbK1XFhnDhyE8f7jJ9NrKb+69S8+Dpxf5w/91U+AcNV
         2upCc+ZHf6kJAjVnMV3I1LZ8jwtm0RH6S31FdKTu+EPAMW8VSA4FdZ7tm5ZGko4xdrBK
         ydtw==
X-Gm-Message-State: AFqh2kqZGjdSIEVM+KEFJp32rGHwKN//DuWT+S+Y4/fAfsB6zaIqKkoR
        5BdWtO4pFs/mpcbVzkbuW4sLY9BNMFMIpEBSbDo=
X-Google-Smtp-Source: AMrXdXsH7RqaoxO0iZCH40SaRq1NMTaoNUhOBacXaJih3JlcUdNFDSYkeyz/5LfMLBYhKnC1N/vUZsTKn5dr0MMMxWM=
X-Received: by 2002:a05:6214:4c08:b0:4c7:1ebf:719f with SMTP id
 qh8-20020a0562144c0800b004c71ebf719fmr418413qvb.64.1674137266231; Thu, 19 Jan
 2023 06:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20230119134218.12280-1-bpappas@pappasbrent.com>
In-Reply-To: <20230119134218.12280-1-bpappas@pappasbrent.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Jan 2023 16:07:10 +0200
Message-ID: <CAHp75Vc4QS=Gr-DSvf7pzCKktqGPfno4TBDmicj5CKgyHGjSsw@mail.gmail.com>
Subject: Re: [PATCH] media: atomisp: pci: sh_css: Replace macro
 STATS_ENABLED() with function
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     hdegoede@redhat.com, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org,
        andy@kernel.org, colin.i.king@gmail.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 3:43 PM Brent Pappas <bpappas@pappasbrent.com> wrote:
>
> Replace the macro STATS_ENABLED() with a static function to conform to
> Linux coding style standards.

I believe the best approach here is to drop that completely and move
its content to be inline in the only caller.

-- 
With Best Regards,
Andy Shevchenko
