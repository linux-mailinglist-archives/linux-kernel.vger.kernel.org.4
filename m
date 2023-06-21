Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16980739111
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjFUUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFUUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:51:30 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923A010D2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:51:29 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so324957439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687380689; x=1689972689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGYpAiy88XNMmlUjr5FQZ3CK1N6sSvAsf2FUdWX3ZV8=;
        b=sENwOAzDLjPvWHbRE+/f+NcMaher9M6XEp0OBodDaskAuwBGBDHcKO6vzwza6cM4oD
         bysCo6EuI5sKrobhFsSG+hbRP2kK8ajYeilLaHbR71sw5BhmXl7kelcXLplSXtBdNQey
         fJJn7q/dmOOo7WHbUhVtC1qHvuaKdn0DSQEuJvmYmS09dpCCKS4OxExX3zBNk3VlSEt/
         fje/Ozj/GsKBDbCw6zfnY711CrCIGpcF4KM6RnQF3qbC5KyEI5MMjRkSScgFOF8CiXne
         f/lIqRWuvCcoLBPq6bszFsArr12axL3jrbLGRw01IyMQHviWGYFZT0Jtt0hTKGHyb2Xp
         yLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687380689; x=1689972689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGYpAiy88XNMmlUjr5FQZ3CK1N6sSvAsf2FUdWX3ZV8=;
        b=h1aN29Wx+Ly9tx9GJwV15BawiqYFNNTB1UfJ0USx8WsAcHgnedSh248DZ2+CmhR7Ji
         UJSb5FJUIxbGpMN9vg/BZXVEnq2WTCZKbZEeetoDf75pv1PSkw0f7U32JQ/f/5mrKzru
         CK7+l/FtpynW1TvPUnmAWZ2STRXGkszolPU/T7QyJOQcDoHYaULgJKybtpOixXqd8vWb
         oZeWSz9DskUcvwwvRoMjn0u+pZeICubnZXe/j0usWJcQWQgM+blhjCvyx+Bq75m/ziB0
         i//FzsL5O1DWgjxrcs9FfwoytWVMCTevlXRWGxlWysEFQ80EjML+91byGEelUFaIVjux
         Nb/g==
X-Gm-Message-State: AC+VfDwGxDZ97YUzSjs8nXjEIcPsaijJqibjy6uEJbuyymDdffca6fKp
        CVtL8HBBkMPYcxTWMMxWm40=
X-Google-Smtp-Source: ACHHUZ6FSRPY3Mr2teV8zeicYVEBEf736GeR538LPdizOy5ArQS/tnGW66GTyegayRZRe/Tc5rSmow==
X-Received: by 2002:a92:c9cf:0:b0:335:9303:4345 with SMTP id k15-20020a92c9cf000000b0033593034345mr15693339ilq.25.1687380688787;
        Wed, 21 Jun 2023 13:51:28 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id p5-20020a92c605000000b00342535aafe7sm1526841ilm.57.2023.06.21.13.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 13:51:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 21 Jun 2023 10:51:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.co,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        fuyuanli@didiglobal.com, zwp10758@gmail.com, zyhtheonly@gmail.com,
        zyhtheonly@yeah.net
Subject: Re: [PATCH v2] sched/isolation: add a workqueue parameter to
 constrain unbound CPUs
Message-ID: <ZJNizvI-7A2hFDoM@slm.duckdns.org>
References: <20230613092819.GA18487@didi-ThinkCentre-M930t-N000>
 <20230614091923.GA1059@didi-ThinkCentre-M930t-N000>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614091923.GA1059@didi-ThinkCentre-M930t-N000>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:19:45PM +0800, tiozhang wrote:
...
> @@ -181,8 +181,8 @@ static int __init housekeeping_nohz_full_setup(char *str)
>  {
>  	unsigned long flags;
>  
> -	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> +	flags = HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | HK_FLAG_MISC
> +		| HK_FLAG_KTHREAD;

Why is WQ being taken out of nohz_full setup? The patch description doesn't
mention anything.

> @@ -208,6 +208,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  			continue;
>  		}
>  
> +		if (!strncmp(str, "workqueue,", 10)) {
> +			str += 10;
> +			flags |= HK_FLAG_WQ;
> +			continue;
> +		}

I wonder whether it'd be better to just add a workqueue boot param but if
this works it's fine too.

Thanks.

-- 
tejun
