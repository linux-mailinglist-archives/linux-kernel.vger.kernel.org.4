Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D724F6C3760
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCUQvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:51:00 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7F28E64
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:50:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o40-20020a05600c512800b003eddedc47aeso4389199wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679417455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OfZP5WUwQ2zes6TJwapZ83j4T5feELIfk8vczVnLdPI=;
        b=E0+aVcsylyia6nwcDEPzALqwWBMGJDgGwUYNgRB3rF3ityRUjdO+sK2wUNsTrhiNiQ
         Tu455Dp1ctS7qVOIAmPAfFT4uzhkmjjqhYrL+Ez30y0vyTjuZD1jTcaax/QI9kfSC6Bi
         v90AwVGmHV1r3dBl01ib0cQ67/9cDEre4QigEPz2G1GOcWIolO6VLJ2BoDsuG7MEjlgx
         pFXPRMw1XzaSxRuhtl1EOp6VoTwtsqGhKip4iO7CAbUpH5fB8jfDIDjPDcFwXNuwd4+U
         fPog1MWrWwyIj/1PJzynAkgsrmW8r7j+s7eAbpgyJxWkkJgGLG5h8qtakcFdnzYykMVl
         87oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679417455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfZP5WUwQ2zes6TJwapZ83j4T5feELIfk8vczVnLdPI=;
        b=bWL03XofhljJ1uu1l2zN16C4KTrIZL1PT3kukafQv2wIDUyozXhCfh5kjglxQcRcXn
         yQ0i5bOcywOZxDvarqEuH/uS9CNBFNEfjq/PWW014421bX8RuzX7z2mMvA1Iw7V0DEuG
         f38p4kWtkDVJ9rNc/lnHRNv24D3U8gTkXKMrBmYLM9SlIwftRnNGL2ueuuUVk7QTqCfJ
         2RLVJVfumhH6ZnMXTUj+kiMVoj9bhfY/uCRtgVhfxfWNjGKQ8SiTKaokVHRNsd3nDJNn
         Iw1xIVHGwPGAQYnDxDXKafJxnUquYZO6HrVa1IRoEjlrxs9rMH2VqjLtWO9sYNX8aEfM
         fVxg==
X-Gm-Message-State: AO0yUKU2i+pGQN2KS7VDeGg0CwnpkzFqEht4/huBUm3VZTKfHS8xLOn8
        dq4PD+yF2+LnVwmk+6b5E6zUxokDpM/zgjbusx5ktg==
X-Google-Smtp-Source: AK7set/5CTKHv7W42iSkRDz6r+Fv5GwBJzTkDXZQnUC7keFECRTnXqtOMDiGp/Vor20x/ruRFYAKEw==
X-Received: by 2002:a7b:cd09:0:b0:3ee:4dc0:d4f2 with SMTP id f9-20020a7bcd09000000b003ee4dc0d4f2mr463024wmj.41.1679417455116;
        Tue, 21 Mar 2023 09:50:55 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13904832wml.43.2023.03.21.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:50:54 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:50:49 +0000
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZBngaarixYOgBCOA@google.com>
References: <20230317143310.1604700-1-vdonnefort@google.com>
 <20230317143310.1604700-2-vdonnefort@google.com>
 <20230320214516.01c18367@gandalf.local.home>
 <ZBnKe55cvTZybZLF@google.com>
 <20230321114047.3432afbe@gandalf.local.home>
 <20230321124425.6ca93621@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321124425.6ca93621@gandalf.local.home>
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

On Tue, Mar 21, 2023 at 12:44:25PM -0400, Steven Rostedt wrote:
> On Tue, 21 Mar 2023 11:40:47 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > 
> > > Thanks a lot for having a look. Do you mind if I fold this in my patch for a V2?  
> > 
> > Hold off, I found some bugs that I'm fixing ;-)
> 
> OK, you can fold this in. I also fixed an issue with your patch where it
> was missing setting a page->mapping and also clearing it.
> 
> I haven't updated to replace "__u32 *data_pages[]" with an "__u32 data_start"
> But I think that should still be done.
> 
> -- Steve
>

[...] 

Thanks! I'll prepare a v2 with all that!
