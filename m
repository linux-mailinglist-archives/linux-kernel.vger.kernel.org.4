Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A633166B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAPBrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjAPBrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:47:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36193A95
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:47:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso32482964pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSr3gBths7LfzOhP3PbG7HoBbxP6OSt6Z7HOZ0qcxXo=;
        b=TwWHWle4nENJdybCYfEUNwLATVa6lRfDW7SUhskQ95K/FfJqRCxcpHsjnb8fHepDs8
         1H8Ip6lJBhjX6JltLk6pklRUbaTjjszDDOqQXSO8TsrzN9DwUdegliA4X32DNzI7hShX
         rV+rwfcCTSFburVZXA7WhwVyh9JnbiP5oIdOZje8pxNdPuhFs6O+ANhtM5Rkfx5ypmNg
         DxrjchoXVuZ4jd8uTRWPyYVfRriANi/YcZVLPg6ENVyHHOAHkJSshuvqEcaSIT/XKJW7
         ETfIeCoBSybkec9vWxEDmku/0mfWX5D1RR9k169/oUB3lPxAWE+SPJ4DUWU0ChJHvmCw
         WPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSr3gBths7LfzOhP3PbG7HoBbxP6OSt6Z7HOZ0qcxXo=;
        b=qP0RvvbLg6pLNtMyB6ogdnr1j6N7cHvRPX/s7leU020zBMZMTc3GeUgDGkMJene4cQ
         AhUsqpxz6qU/ebVpH3lHAee0wfL5D/XS0okCkaZzRjrVEz4L04OiyESXrqK8IHjtEF0P
         +0cUuxUrIQh4nMx7rUkfZdUF4P5deSShUlJsIyCnjMFxQQkZW2FWscawGlhxlqZjsFiD
         XCoUeGY3EfIIBSuYvUueeWkoJ8Jb+defw8PgOaRZnqYmi/LD8nXhRMo2BlfeLFb+HFDp
         K/l/exMFDcHoVNtFfe0ZPtB2FGrt6qs+IDes2UQjmzysUKe6Mxjp4r4pa5Pe5ixROYBh
         O3lg==
X-Gm-Message-State: AFqh2kqN2DnzWxcDU75IlnzmfmzVz+7S4Gi1hkO92sT2Kbq8oXt+jbR3
        w9mLPDejQOAPIE4jd5LWVTk=
X-Google-Smtp-Source: AMrXdXve+Ct7yuT9wUiewycnlfGeBeR6Y20nXR/DrHTnfkVDxHZul7Xv77WqoccFtvZBdleBCVHn1g==
X-Received: by 2002:a17:902:eb11:b0:194:46e0:1b61 with SMTP id l17-20020a170902eb1100b0019446e01b61mr20978703plb.63.1673833626434;
        Sun, 15 Jan 2023 17:47:06 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b00187197c499asm17985883plk.164.2023.01.15.17.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2023 17:47:06 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:52:20 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <xiang@kernel.org>, zhangwen@coolpad.com
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] erofs: simplify iloc()
Message-ID: <20230116095220.0000093d.zbestahu@gmail.com>
In-Reply-To: <20230114150823.432069-1-xiang@kernel.org>
References: <20230114125746.399253-2-xiang@kernel.org>
        <20230114150823.432069-1-xiang@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 23:08:23 +0800
Gao Xiang <xiang@kernel.org> wrote:

> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Actually we could pass in inodes directly to clean up all callers.
> Also rename iloc() as erofs_iloc().
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

