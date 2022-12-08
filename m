Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF574646C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiLHJqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiLHJp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:45:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137E376173
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:45:42 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j206so1006454ybj.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vHLlGPSWqK6jIiBQvorhk1+88+5nltVyP3glbpWJNGU=;
        b=nE7GaTwUljG+UPAlrq/8LVWKMRIBt49XTm1xOuTswWk18cj3Ci0OxGkmTMvAWZUN+8
         7kByBD8v+kf8XAy1HPWusFzdTyon63ep7CI5CPW7KNU9SC+knx3fNi5/wqje0T3pFH/l
         LFQvD0GVtoERHebO60seC/eHYRHgEi7HJn5fzMskGMxkmX0O9Wyr8N3RMSeOB45sBAWh
         zG3wdmTSLM8WjXvxzMOMQ2ceTROlo+iL89SgYecGiSTeAc8ZGMyi4HpTrvTuC7EfcwXx
         WW62+8zdAXXM4yjm6ZTdKTIrsozLaHQnvfmLBrTHtSbHrpS5BF1dmHvszGVxxUd2vLlY
         nfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHLlGPSWqK6jIiBQvorhk1+88+5nltVyP3glbpWJNGU=;
        b=WLWy7+ynJ2BEWmUO1dZIKc7xFjJFZTb5KDcYiejfQzwQNcEgSefRLy/dek6xry+sIs
         CecJ7NJMvXbIQlMcNkKNFZe/AsGBThcleqiF2R0df78Lccs++iUiMLsGs2sfB1yM5gZt
         rO3ofKInEASm6zfxi84hJf1dBx//Iyubwp+36USqnL/ZgsLcdN6EhdenX+AxAkoO7iFr
         zvSjASRnEKGbY9rHGyUpvy2CbA6hJRJjVCYZFqOZBzHcN9wqQswoZSTTYC1qP0/Rn73A
         T2AIl+5OQ6pYYpeMnj/ZQ+a4Z5V6t52nVwonLhD+15gqh7kTwL75zfjaLVcRTw7aXDQB
         ODjA==
X-Gm-Message-State: ANoB5pn4tCIMfO8EsKSesVykXY4QgBbDT1qmogYNPEIPGHCj6CADqLrg
        YlxzjZo70Jq2Uw0/GqDP5QGNgX5/0AmR92/nh2kv0w==
X-Google-Smtp-Source: AA0mqf5dyqYndZKuymdvDwLD7L7hq0Q/58j9fOfP0KxnLzNwcxaQzPUw3plUVXKkisauzFHBOv4gj8Sq46gUsJPk2mo=
X-Received: by 2002:a25:74c7:0:b0:6fb:67c7:33e1 with SMTP id
 p190-20020a2574c7000000b006fb67c733e1mr32493014ybc.255.1670492734967; Thu, 08
 Dec 2022 01:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20221207112924.3602960-1-peternewman@google.com> <IA1PR11MB6097B274AB8223D44CAFF4899B1A9@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6097B274AB8223D44CAFF4899B1A9@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 8 Dec 2022 10:45:24 +0100
Message-ID: <CALPaoCj7JanopjrvZEOvpnNWv_-e2qgre+OLxS5A=3q3hkn0pw@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: Fix event counts regression in reused RMIDs
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Fenghua,

On Wed, Dec 7, 2022 at 8:26 PM Yu, Fenghua <fenghua.yu@intel.com> wrote:
> > Fixes: 1d81d15db39c ("x86/resctrl: Move mbm_overflow_count() into
> > resctrl_arch_rmid_read()")
>
> Are you sure the patch fixes 1d81d15db39c? This commit is just a refactoring patch and doesn't change resctrl_arch_reset_rmid().

Yes, the breaking change was actually in __mon_event_count(). That
patch removes the initialization of mbm_state::prev_msr and switches
to using arch_mbm_state::prev_msr.

-Peter
