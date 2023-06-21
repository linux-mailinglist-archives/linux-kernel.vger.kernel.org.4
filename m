Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CDE738E22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjFUSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFUSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:07:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DD1A1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:07:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b53b8465daso28937195ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687370833; x=1689962833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0mDUPFj11nuzbslsfyhT+92UBRubLuDHdsEFduMyK80=;
        b=n6bV3uQ7OgCZ/yga2+UJO5z5CEhWbBMkdYri0JPYVguITaSNOVbLW9WsaAsITk3kxw
         o9P4nrzM+Be5H+junB+qkqlf3w2eTTkCY+ocPEiXo3sUytB2VR3fTmPOysfgKzdVpA6p
         TvzhI7R/ox2t4j73CHoRD5wNkIxKRn1dsp5eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370833; x=1689962833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mDUPFj11nuzbslsfyhT+92UBRubLuDHdsEFduMyK80=;
        b=Tq/wijL99TLXy2NSeKonc3UJYH4PYzJK26MO5OWEHqpD27gMhPFoOvyTFu8rMDT9qD
         pvXBvQJw7Ulsi6Mlc9R4WbuZG7lZm38PnD+e3PCKscg/F4WIawFVziWG4y5kNgCXfJdR
         zoVtjACRRdulmsw4oXRdCpKE9sZtTgQ3QgZZp+32u8pmiiZJiC0Q6+1dQU/n8szdzDiI
         eeZ+4jcDKITQiAsRcS0fDxMWQb/Lud3c4WQ1YccAWU88DU1aZ3pmrz0ETA8sDz3kaL0T
         8cO2TSLpFqfo7dqRATgmEkbmoWMXWwf+ULZxgu9zGoFXCTsIne5SL0WjCf4ZhGroV0sN
         vMcg==
X-Gm-Message-State: AC+VfDw13GN5gx2v5687MZEGqfstcVs904w55lNH5SE2XPPBPBD2H0vv
        KH4mdXrm/ITTCMEp1ncObIIxmag+z35HA0Aqo/Q=
X-Google-Smtp-Source: ACHHUZ6PIEaMc0p6XfyU4qJlLRAtxldxq529qgRDiWsUBCHqqIJExPIIilP4/iIPS+XqfD3juP7Dqw==
X-Received: by 2002:a17:903:11c6:b0:1b3:ea47:7972 with SMTP id q6-20020a17090311c600b001b3ea477972mr13653002plh.38.1687370833248;
        Wed, 21 Jun 2023 11:07:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001b3cac25f82sm3819234plg.139.2023.06.21.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:07:12 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:07:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
Message-ID: <202306211107.26A6B76E@keescook>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.194131053@infradead.org>
 <202306201454.0A2E875F@keescook>
 <20230621081857.GG2046280@hirez.programming.kicks-ass.net>
 <20230621084802.GA2048237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621084802.GA2048237@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:48:02AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 21, 2023 at 10:18:57AM +0200, Peter Zijlstra wrote:
> > (and I need to write a better Changelog).
> 
> Updated changelog...

LGTM! Thanks :)

-- 
Kees Cook
