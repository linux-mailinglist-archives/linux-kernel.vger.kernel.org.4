Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3E6F60AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjECV4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EE17684
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683150924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aRUy8fQIjPClPN9HCJtt+C0DKsdLlhX68tqTevi/WdQ=;
        b=bpGhVfT9sPsRONmzrwhLuFY1PtwjNM6jUD2FNQU8zshF8EFCUnUaYHDzEmlsztFSSjskFm
        wjZUF4K86uSGuHDwzD9/5wf8F6y0DtiGwo4rwX7cPenWOiLju2AqAme815JU0ViIr1LJr+
        D9OJdsxWqcVwmvqELi1qEouSkrliexo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-b1MGFw20OJiuZUJpAFN6rA-1; Wed, 03 May 2023 17:55:23 -0400
X-MC-Unique: b1MGFw20OJiuZUJpAFN6rA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f3157128b4so25424885e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 14:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683150922; x=1685742922;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRUy8fQIjPClPN9HCJtt+C0DKsdLlhX68tqTevi/WdQ=;
        b=IHCe4jV6sjuA+V4AdRUNuCHevxC1Qpcum4rZOuOFv6BI0M+O0Bsku5WTX6GbD+EGCk
         y9gIvs00CL5SV1AykTCQAESqFoNdElqvyeI+OkpyWesUbfkcCnwpDXaWs5FOjQuG55PW
         ICunI2icrof1AHXUzw83oQzFA+2ZDLbfCdWhFo3MzEJgBXj0FyW/DMXX0CPVOt1YESDV
         +ax9W+aOI2Cw/siMrBLCsnPMskgt2lkLSMBKqV9PETYQIYlzYRhecXSWfL6gHomHoG7B
         WnqYITXXKZguKINXNMo31IGPsjr2JnCxbe2HiFnGnM+w0lG0DE5a11LixXiu8DbfSJfn
         PWmQ==
X-Gm-Message-State: AC+VfDxx2jq60cTG1m0ZjK4zi5z2XSzndO3F9ngG51BGZbGRdy4ao1i7
        2yik0Pd5tiph95yNy3zY98E21iQ2vOeZnTMwTjW/z64UYwJ7ykLSCPBGwW2MC1852BV/BPdSUTB
        xjSiv7vVgs2MKRya/oK8gqnQC
X-Received: by 2002:a5d:508d:0:b0:2f0:2d96:1c5a with SMTP id a13-20020a5d508d000000b002f02d961c5amr790260wrt.32.1683150922203;
        Wed, 03 May 2023 14:55:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4EOt86nc6cbqb31wNKWhCWMZZP+Iyp7c7zJw9PvZLVtTq6pn553v3IlJvkk7Xqdg2QwOu0sg==
X-Received: by 2002:a5d:508d:0:b0:2f0:2d96:1c5a with SMTP id a13-20020a5d508d000000b002f02d961c5amr790252wrt.32.1683150921888;
        Wed, 03 May 2023 14:55:21 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b003048477729asm24820970wri.81.2023.05.03.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:55:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: tests - fix input_test_match_device_id test
In-Reply-To: <ZFLI7T2qZTGJ1UUK@google.com>
References: <ZFLI7T2qZTGJ1UUK@google.com>
Date:   Wed, 03 May 2023 23:55:20 +0200
Message-ID: <87pm7hw053.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

Hello Dmitry,

> Properly initialize input_device_id structure in
> input_test_match_device_id test to make sure it contains no garbage
> causing the test to randomly fail.
>
> Fixes: fdefcbdd6f36 ("Input: Add KUnit tests for some of the input core helper functions")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Thanks a lot for fixing this!

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

