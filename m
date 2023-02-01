Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423AB68634B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjBAKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBAKD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:03:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50D4A211
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:03:25 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 7so7185394pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9NQoVmd5YW7E4nDi11u5QY3Mwl3QSqffLyWVWrqddA=;
        b=A4mG3U8bLTWj8m2k5Zl3yOzxK2Fmbxv6gwFmYSLbt03LurmGziuLyVrthP5evCBA7Z
         1vwIMQa39qyFg+MtrIVXRbz9EahFQPQh0ltz57TOFrSUx8KqVkyep5wvd43doCIRIAXJ
         i6pUSn/JKRXljCafkeodOLzWg52ORXWBcBXPEEZGNKxVpfuwHyO7t7HMob4wSzxhi9HP
         Cn2vV46SkYehRrazWVxhRTuuuQlXGIQh3gqjCCoQ5soHkJeex0KJKQKrf6xBvY2SuFnA
         6YOwNkM0BMNtyoHSNYcXTcXXe1SPNEPZBEc6fbOFykkwoWf46N8eu6n+/ue147zqI8jG
         HgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9NQoVmd5YW7E4nDi11u5QY3Mwl3QSqffLyWVWrqddA=;
        b=x872utq72RLbk40Tk3Kp1EWo0bWFa8nDv+U+gcUHBbYpZ1ZLZUK/zKnmcmbYmH4Xkm
         7ekPEtawXf2CHxsNirpc8R7xF1kQPwxzMBL3UsioEK9+vCWFTgRo6/rvxLJihdBgLU5c
         PFXxFYtju/IGfA9KFELQ6L5+Y2HfyHaiVDIwM3O/tJWUfUazQ5LonifNuyncEfTiFM/X
         VDLGzjhkI3j3HOKXvUQhu00Yvao1olWa0fbKP0N7gJx8luHv0V3gurHwAwUPiI61Vosa
         iPItSwRuuK/suoxouM74g/PikeTxXq0v+eHa2Y5ZLnKCj3ATQau8ZllfihJX1not1DjZ
         FILA==
X-Gm-Message-State: AO0yUKXQT39tmzZtacloOaRn/UX1TlYSPulEqA1PxAAkrgSjvutT31lK
        8GOUQTiwFjhEH40Kr3iOec0=
X-Google-Smtp-Source: AK7set9GPruDQWfIvIRd51u8aqCdDVHnT+tCqnvI711CcYCaJQN5Ha80t3+5dvtJGJrC5EmrR/n2Xw==
X-Received: by 2002:aa7:8f06:0:b0:593:9620:383 with SMTP id x6-20020aa78f06000000b0059396200383mr13153056pfr.28.1675245804965;
        Wed, 01 Feb 2023 02:03:24 -0800 (PST)
Received: from min-iamroot ([210.91.70.133])
        by smtp.gmail.com with ESMTPSA id j14-20020a62e90e000000b00590684f016bsm11037553pfh.137.2023.02.01.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:03:24 -0800 (PST)
Date:   Wed, 1 Feb 2023 19:03:20 +0900
From:   Hyunmin Lee <hn.min.lee@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Jeungwoo Yoo <casionwoo@gmail.com>,
        Sangyun Kim <sangyun.kim@snu.ac.kr>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH] replace BUG_ON to WARN_ON
Message-ID: <20230201100320.GA5460@min-iamroot>
References: <20230127115844.GA1124261@min-iamroot>
 <Y9eYbPuq5Nw9Njxf@kernel.org>
 <20230131105629.GA1195431@min-iamroot>
 <Y9kb2XUunZlgsu2z@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kb2XUunZlgsu2z@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:47:05PM +0200, Mike Rapoport wrote:
> On Tue, Jan 31, 2023 at 07:56:29PM +0900, Hyunmin Lee wrote:
> > On Mon, Jan 30, 2023 at 12:14:04PM +0200, Mike Rapoport wrote:
> > > Hi,
> > > 
> > > On Fri, Jan 27, 2023 at 08:58:44PM +0900, Hyunmin Lee wrote:
> > > > Replace unnacessary BUG_ON to WARN_ON. These BUG_ONs verify aruguments of a function. Thus, the WARN_ONs return an EINVAL error when their condition is true.
> > > 
> > > Some users enable panic_on_warn, so for them WARN_ON will still crash a
> > > machine.
> > > 
> > > I think a simple if() will be sufficient.
> > >  
> > Hi Mike,
> > 
> > Thank you for your advice.
> > Would you please give feedback about the below opinion?
> > - Printing warning messages is helpful to inform what happened in the system to the users.
> > - When a simple if() is used instead of WARN_ON, the if() should print a warning message.
> > - The condition of the simple if() should also have unlikely() for optimization of system performance.
> > - WARN_ON is a macro doing like thoes easily. It has a notifying function and unlikely optimization.
> > - Eventhough WARN_ON will still crash like BUG_ON by some users who enable panic_on_warn, it is their intention. They should accept the crash by WARN_ON.
> > - Therefore, using WARN_ON looks like natural and efficient.
> 
> As this is a validation of the function parameters, there is no need in
> warning messages and if(unlikely()) will do. There is really no point in
> WARN_ON() for something that's totally recoverable and very unlikely to
> happen.
>  
> > Best,
> > Hyunmin
> 
> -- 
> Sincerely yours,
> Mike.
Hi Mike,

According to your guidance, I will send a v3 patch.
Thanks a lot.

Best,
Min
