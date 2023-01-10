Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EEC664623
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjAJQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbjAJQcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:32:10 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43576FCE8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:32:09 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id v23so8835690plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 08:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RZf8KE2jGADdnneGpH5rMIEd+76rQYqRcfU6WstpDcg=;
        b=6NAHB2GW7EvN93wl5qF4QCuvm+yzT2rAkU6qb4Imc0cJPZvPMO+630AKFbiemUm/Lg
         O0mPXC7DLCHS2JPswsGg1B9Nu21/LQsNa1J9PV5oYp5BDiui6g9J5lk9Ye+8kvMn0Llu
         Ul4/SD2BjRVgTyJOFTegVtqnj+vUmOidxDfManycD5hPV15K3xXExyoZwqgxfvbmRlDJ
         NZIDkUY9qHe2Yz+7V6OnoXnMnj7TDi+a1BAzwVpiy9QNvBkHYVguN0w0Fxr2d2PGvPUa
         ISJwlDsbWtL6yeF2TnAAYsY0Goy00knhGChqXoIDthjrMBp65ec/DSXDa1PkU7mNogRP
         n5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZf8KE2jGADdnneGpH5rMIEd+76rQYqRcfU6WstpDcg=;
        b=Z8hrcZgAw6SS+zxJTaA4zZi/LnJbJxkaqpG6b65TeLZipBDxlM30zzg4KoN7a1QsU8
         uug6lZgrL0ysRRclRZMw1O64BIAZ2spbhR09qHk6b9sWIHKQrkRjnvdIyznDhLRo8xiJ
         qtWhdEhJ+LuQkw7F2EOig4h3pqppQbSgAJzZDLMWg614bYGBr9cm9aJKq4Dfo2DiKROm
         4G0BjkxrknWRbV/nul3IlojBgW/D3RVvSFc3XX3bgQPdY0BnX4z93RItMOUx0YE1dyOP
         limZY+YfDOTqqlYyRDZ5yL6VPVTvwEqu+WcybG+xPSEgqKmFGKkH/9m/ZcGlTRr0gaIK
         TTyw==
X-Gm-Message-State: AFqh2krgJBGdyRQjVguTKvV622Zs2neaKlZMFoUBR1H6N+ETV9UXKkAe
        i/T6lZ1eLe8u08zkKjeCtQ1R0g==
X-Google-Smtp-Source: AMrXdXt2CQ1h4vArV4X6bU2e/QV8Xwnv1ErGXRGt/sziNANSyWOFaFG3tzEDkhE5PE35+Dv+i5rn1w==
X-Received: by 2002:a17:903:234b:b0:192:9f2d:d6b9 with SMTP id c11-20020a170903234b00b001929f2dd6b9mr59190932plh.9.1673368328762;
        Tue, 10 Jan 2023 08:32:08 -0800 (PST)
Received: from localhost (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902e80600b0019251e959b1sm8272787plg.262.2023.01.10.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:32:08 -0800 (PST)
Date:   Tue, 10 Jan 2023 17:32:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/i40e: Replace 0-length array with flexible array
Message-ID: <Y72TBSH/QnJhnYIx@nanopsycho>
References: <20230105234557.never.799-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105234557.never.799-kees@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jan 06, 2023 at 12:46:01AM CET, keescook@chromium.org wrote:
>Zero-length arrays are deprecated[1]. Replace struct i40e_lump_tracking's
>"list" 0-length array with a flexible array. Detected with GCC 13,
>using -fstrict-flex-arrays=3:
>
>In function 'i40e_put_lump',
>    inlined from 'i40e_clear_interrupt_scheme' at drivers/net/ethernet/intel/i40e/i40e_main.c:5145:2:
>drivers/net/ethernet/intel/i40e/i40e_main.c:278:27: warning: array subscript <unknown> is outside array bounds of 'u16[0]' {aka 'short unsigned int[]'} [-Warray-bounds=]
>  278 |                 pile->list[i] = 0;
>      |                 ~~~~~~~~~~^~~
>drivers/net/ethernet/intel/i40e/i40e.h: In function 'i40e_clear_interrupt_scheme':
>drivers/net/ethernet/intel/i40e/i40e.h:179:13: note: while referencing 'list'
>  179 |         u16 list[0];
>      |             ^~~~
>
>[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
>
>Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
>Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
>Cc: intel-wired-lan@lists.osuosl.org
>Cc: netdev@vger.kernel.org
>Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
