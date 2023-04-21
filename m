Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E226EB227
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjDUTPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjDUTPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:15:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAF749E6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:14:38 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b73203e0aso16228372b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682104478; x=1684696478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jEgvnbrmc3TuMJvfDzFRQ8r7bac/zec/QDnNR+fUu8o=;
        b=XaoLIVvhAeXIoGslsijhHTqvr5OalUonOX+tyIs6Ddonyz6IfPbZONBCCPmwbOnIal
         +48DAhCUPm2K5TjUujQxz0rWUwr9B9Ln+ubWLI5Yq5o5+7yyaPX6w7Dx1youqzZpcpEn
         tjtdehYOl/YFN6y8LIVKV7KUt5Op3re6w+ojw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682104478; x=1684696478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEgvnbrmc3TuMJvfDzFRQ8r7bac/zec/QDnNR+fUu8o=;
        b=b1Vps7Dm8UINIHShA1sG6VRzTgTxBlt1bu8N5SqqYE6MPd7y+ETQHdtVpmDgf/jNCP
         5+YBKwMH8nDiio4pp2+I7N+11E8OrRxdv9BmnAtf0W7is2KLFJGLoo14OKoFhH73ZD6o
         GWMdfMOL4n76lDqUqua1SVeloR3Fszx9G1d4q6LZFX4VP6xPMncL/yWrM+fIRvWl6lT3
         Bz09vCbejOxXKQaG9azdCjKzbujneqlh5bxI0D9FsyYLTkg7GyH5O+sMIfxjbw+yv98d
         lpWD+Ds2GTvHGpTRuDSO0eGB7bFR1Auq8nuQWhYrUCNRMmxHUfTWS9+zn5R/7TVMjN71
         LXzA==
X-Gm-Message-State: AAQBX9fsp2M6FBiwBa9BAFnn8mM23pkHOUm08zaxRWztRrscsLvXWT9+
        qhNH6bvljfLXu9WfMbiy0NSHTQ==
X-Google-Smtp-Source: AKy350Y1f+YAGYXv9LimfavyX8lKVpE9VjmW53qYwi1ozA+66yPdlwNXJo3fUaJrly4Ejdz2PSnCZw==
X-Received: by 2002:a17:903:24f:b0:1a6:4032:ef2 with SMTP id j15-20020a170903024f00b001a640320ef2mr6485460plh.28.1682104477975;
        Fri, 21 Apr 2023 12:14:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e9-20020a170902744900b001a656784229sm3039333plt.211.2023.04.21.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:14:37 -0700 (PDT)
Message-ID: <6442e09d.170a0220.86574.6e1e@mx.google.com>
X-Google-Original-Message-ID: <202304211210.@keescook>
Date:   Fri, 21 Apr 2023 12:14:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 01/11] LSM: Identify modules by more than name
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-2-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-2-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:49AM -0700, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> the name of the module, an identifier associated with the security
> module and an integer member "attrs" which identifies the API
> related data associated with each security module. The initial set
> of features maps to information that has traditionaly been available
> in /proc/self/attr. They are documented in a new userspace-api file.
> Change the security_add_hooks() interface to use this structure.
> Change the individual modules to maintain their own struct lsm_id
> and pass it to security_add_hooks().
> 
> The values are for LSM identifiers are defined in a new UAPI
> header file linux/lsm.h. Each existing LSM has been updated to
> include it's LSMID in the lsm_id.
> 
> The LSM ID values are sequential, with the oldest module
> LSM_ID_CAPABILITY being the lowest value and the existing modules
> numbered in the order they were included in the main line kernel.
> This is an arbitrary convention for assigning the values, but
> none better presents itself. The value 0 is defined as being invalid.
> The values 1-99 are reserved for any special case uses which may
> arise in the future. This may include attributes of the LSM
> infrastructure itself, possibly related to namespacing or network
> attribute management. A special range is identified for such attributes
> to help reduce confusion for developers unfamiliar with LSMs.
> 
> LSM attribute values are defined for the attributes presented by
> modules that are available today. As with the LSM IDs, The value 0
> is defined as being invalid. The values 1-99 are reserved for any
> special case uses which may arise in the future.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-security-module <linux-security-module@vger.kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Some nit-picks below...

> [...]
> +/**
> + * struct lsm_id - Identify a Linux Security Module.
> + * @lsm: name of the LSM, must be approved by the LSM maintainers
> + * @id: LSM ID number from uapi/linux/lsm.h
> + *
> + * Contains the information that identifies the LSM.
> + */
> +struct lsm_id {
> +	const u8	*lsm;

Since this is a %NUL-terminated string, I'd keep the convention of
leaving this as "char", and perhaps even const. And "name" or "lsm_name"
seems more descriptive:

	const char *const name;

> +	u64		id;

if this is "id", "name" makes sense above.

-- 
Kees Cook
