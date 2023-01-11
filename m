Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE55B66659B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjAKVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjAKVZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:25:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9827B7CD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:25:21 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v23so13234797plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=isiHwCTIoSENRpWwMehTehvClsZpOj/mU5tiBrBvyOg=;
        b=KODnx62o2YITMkZtLn5TAKhNM9ViUaeHdj9VjXJu/gHD+gH9FMAwMdxd9S9Ntb2qD/
         WxCsAxQoAwpJ/OxsMAX75z+niJFc+AWtYUiS09V5oCcA39kxAPcD4ncfHMGHdmWgwKfb
         gDzFgredSbRch4xBb/p8uj1iYCpaT5ViMVW6ljLuHgP3fLV0sFbvdJOLyZC7mr3G7lJR
         V2L0JRHU8Pn/bXdRzrYsj34McL+Fn+7ElCL1BqVozAQy9Oz89HURV7QDAD8c02CkHhAS
         2VoM0J9NnsuXREtxE89v9ZJBaoOetEiqm/n0lbZYIcjAOHyhpDq35tURWsqq27L1V9FF
         /7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isiHwCTIoSENRpWwMehTehvClsZpOj/mU5tiBrBvyOg=;
        b=kn9Gb7fjTQA8A3wXh+gMoqTJTRKV2ofne9Agu0rXLYFW3vdvOLabzPiDweHDxUPxSM
         6cfpIkFsgsWdo21KUspZBNMdwrhOwlrna0LTe5SkGxkZzhD6hzaRA5bAa8vZotkWg2QW
         sBbCvne8opQsHSEMWxl38F42KzHEPxDPb7R4j0QsSKEGCUsR6FMbZI9oBj5EntYC1RID
         SiMuNyyIMnBtKjZ8SGauQEpB/NQDaFXSA9Vl/wXs36LMBV+AQGk9BGDz+ex8QYiKNExB
         vderVSRO7nRudGLrR3snYRqZayt7/T7TlvCnGthU4D20/vVI4O3k/Ychv/rNC6B4YnN7
         s6xA==
X-Gm-Message-State: AFqh2krygEPgQucu8P2vkPieZ6wU7E5m5dybG+K9UprWu4k2KJBRkixC
        wO5wufTCepFvipPWWQZVkrfLiw==
X-Google-Smtp-Source: AMrXdXvKRkQZXBDq3VgD7eMaL2oaCGMXrXbnpTAy1wa0mbklDqdGfRFLsGOVTct14OhG9MnRmRGavw==
X-Received: by 2002:a05:6a21:33a1:b0:ac:af5c:2970 with SMTP id yy33-20020a056a2133a100b000acaf5c2970mr588164pzb.3.1673472321232;
        Wed, 11 Jan 2023 13:25:21 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w11-20020aa79a0b000000b00580e679dcf2sm10368318pfj.157.2023.01.11.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:25:20 -0800 (PST)
Date:   Wed, 11 Jan 2023 21:25:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, bgardon@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] KVM: selftests: Make reclaim_period_ms input always
 be positive
Message-ID: <Y78pPcNuXsjpE3DZ@google.com>
References: <20230111183408.104491-1-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111183408.104491-1-vipinsh@google.com>
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

On Wed, Jan 11, 2023, Vipin Sharma wrote:
> reclaim_period_ms use to be positive only but the commit 0001725d0f9b
> ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input
> validation") incorrectly changed it to non-negative validation.
> 
> Change validation to allow only positive input.
> 
> Fixes: 0001725d0f9b ("KVM: selftests: Add atoi_positive() and atoi_non_negative() for input validation")
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> Reported-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
