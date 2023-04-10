Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F96DC953
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDJQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDJQbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:31:44 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D5419B2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:31:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q15so2117486ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681144302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sHVVN6oTtru9Zp5JWJbbh+zOuZxw8Uvr9aoYu9AkWkM=;
        b=Y3CDiubLut2AB6QPV32bn/FfuOMZWWix66aTa31ZRqltIrsJFxAgIlNRPOewA3MZBr
         nJxKYWYlqk8hgLD+6TwUnJB1pxm0/CRalftqoW4fcn4UW/49Q3R5HX65hXxLlHddhDAT
         6vUgKi5L+bn/tx1Mz/BQRITWMKXE8FkZvr2DPhVXenQTmb0UiwqosO3qnabdMeQvwogg
         +ZU9MculDoXd1poXG2BqEvgleELf7EOLXg1UOuhY7mhM7nGE80JXW8om0mgGsFcOUoml
         E8cBqkDEte6py5pFWlKxbmUKaBGZ37TvpBtEdYnH8jXYsBUhmeYWepBPDH8hyxCp/BFj
         6lkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681144302;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHVVN6oTtru9Zp5JWJbbh+zOuZxw8Uvr9aoYu9AkWkM=;
        b=O1wVGLqof9oXcjgKQErh4ZYmXe4VGmzi8aY3eWYhGV8jmomu5Ps7sKEOUSEKFXnH/1
         ormYn0AG6rOEDiLzbsLe74xx+agsYGu4fsvmq6pJ81YOsPpf9+jNAA1/A77SfeRgRPAD
         QxUHsF0rlEjpesGgI50uQ4cl5/7515kLAtZGXHhEpQDDkBL0LD1SRVcyj2mhB0XZZ0J1
         Gu8X6U749mDiCRpesGmj139jjCGik46k/eNZFjCkzt/Xw1lqqZ09RpNbm/hp25Uw7HA7
         o9MEH9TjTfk3ufIztNyiZtWvRU4J7g8UFUjqw6c2qxqSCy1OTHAo1WG1bzXs5uYfhEDR
         i08A==
X-Gm-Message-State: AAQBX9cdk84HVwkteHLPVmC1hTzfjS4f4FJc3xJRdVmsFSLS/SDutn4A
        lKRi1rd3p6q5ijZwsgl/Tr+OMGsJxd8CvMW5brVK6A==
X-Google-Smtp-Source: AKy350ZD5k8n0iaqSVhHkXIKwrBzfIpr7iLG2LzwFj5BEaUDz6+sdM5XQD8GXsHOvli8+zrafOFWrNFG4ucfC7AshTk=
X-Received: by 2002:a2e:780e:0:b0:2a7:7470:4ebc with SMTP id
 t14-20020a2e780e000000b002a774704ebcmr1368279ljc.2.1681144302005; Mon, 10 Apr
 2023 09:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230326144701.3039598-1-nikunj@amd.com> <20230326144701.3039598-5-nikunj@amd.com>
In-Reply-To: <20230326144701.3039598-5-nikunj@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 10 Apr 2023 10:31:30 -0600
Message-ID: <CAMkAt6r4-8zwW8_JbTG6zK0DFG9PVX5Z50Xrq1C_fLBCdsrqdg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] virt: sev-guest: Add simplified helper to assign vmpck
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        thomas.lendacky@amd.com, dionnaglaze@google.com, seanjc@google.com,
        pbonzini@redhat.com, michael.roth@amd.com, ketanch@iitk.ac.in
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> -static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
> +bool snp_assign_vmpck(struct snp_guest_dev *dev, int vmpck_id)
>  {
> -       u8 *key = NULL;
> +       if (WARN_ON(vmpck_id > 3))
> +               return false;

Should vmpck_id be a uint to match the module parameter or should we
check if vmpck_id < 0 ?
