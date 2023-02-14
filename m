Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A8696BED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjBNRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjBNRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:42:53 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F0EAD2E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:42:52 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id d16-20020a17090ad3d000b00233f132b99dso3712782pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qpOCg1lxpw0K+BuGz+WGampNAyAb84XQnWKu/NkN0RY=;
        b=IEII3ryXGaTsmPlox0H7PpAhkkSVbrdQooketGjK2YGWrYxcagHfVyGamgHa20pGxd
         MZHlk2dXjYfP1igtOLZsdca1s9HvcUmvFAcF9xQOiCqcDrDbg+RjDMAdI850xSNXnlcB
         Uj9nalCbBY5CHLNQDVdn2AdgNeBQ7Rlu0rQbeQM002suoehJOkQtYZ4rLoh9lXO7dR44
         3BNI2a+8O5vBDSDP1h1EbliQB/ZutxBzNzf40lCIIFBhA2DDMoJ4RSwwS7WKUEfrt+B5
         pI5MqQnWMHAFB56qQrKcFARd/u5ZuQF7ED29U351fxcGVFK6GBjoPxrShU5lZ5ti4Xpt
         cRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpOCg1lxpw0K+BuGz+WGampNAyAb84XQnWKu/NkN0RY=;
        b=kk41z8mxdHa6mgvZFzut2oDsxIBSjGFYAXz7/NZrJU81woISxxXkDkljtczh5Hob/w
         RQeQ7++mwY3Eaxppx5hXyUzUYHGP+LsAPUN8jqrI8Y7rbQn9f4j5QW4iMt/7gfURXWsB
         qQonCITU6goB6xRixz2dUs1p3xtCLT0Lo0YdPcOMhGALmMCSDDsGplHKr7A2Up7RGWED
         L6BHxw/YBRoyIkJFsbhn8d3s8//q3iEKr9hAGsrJ3eslXeFlH6ItSzkj2aiTjJ4wu4IF
         eMcc9AOb3+gidnOrJy1+V7YYGOGoX61634gvp2tFOhDUkIK9FEzdCp5HDvznREcios8H
         inYA==
X-Gm-Message-State: AO0yUKWP0RJx2hsiCQzt4TVwPE5/SVa+CgsIRyf8BblM7tH6Zq+WVUc9
        oQ5lGf1RqlxJKli7YF4alR66WQOKZ8I=
X-Google-Smtp-Source: AK7set9Z6Awwc+T/2wmSLLjKb0ywjpf7XGOl83rYeLgkAXBaicxPa824sDVclzkhc/GM8G6qKjl4Xh3xBc4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec87:b0:199:2069:7dfd with SMTP id
 x7-20020a170902ec8700b0019920697dfdmr943039plg.4.1676396572265; Tue, 14 Feb
 2023 09:42:52 -0800 (PST)
Date:   Tue, 14 Feb 2023 09:42:50 -0800
In-Reply-To: <85b3d348-2e4a-43aa-0131-27e9fc375cf9@gmail.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com> <20230210003148.2646712-9-seanjc@google.com>
 <85b3d348-2e4a-43aa-0131-27e9fc375cf9@gmail.com>
Message-ID: <Y+vIGskVnzMbfIQo@google.com>
Subject: Re: [PATCH v2 08/21] KVM: selftests: Split PMU caps sub-tests to
 avoid writing MSR after KVM_RUN
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023, Like Xu wrote:
> Nit, could this patch be applied before the relevant KVM modifications [1] so that
> a CI bot doesn't generate an error report before this selftests patch is applied ?

Yeah, good call.  CI aside, this patch should definitely land before the KVM change.

> [1] KVM: x86: Disallow writes to immutable feature MSRs after KVM_RUN
