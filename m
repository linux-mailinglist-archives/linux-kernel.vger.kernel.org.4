Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0FB624922
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKJSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiKJSLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:11:38 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC5B1E8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:11:36 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso2326471pjc.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3KjNTpLOPDuLim619IQREZFftn5V2sNi5JTbC4OhKs=;
        b=oiArtXo3dsDIZIk12+3d8muTDIH47YeNGsnvYXG3IHNf3+UGklQXlFVrj2rA9KCfbc
         kblMU93BWPTbOsLR/i4DiGyZ+/hy7AGvr8rcGMqTPDqN9dxI6FJboTjwVxtSSFXN/U4j
         43jX0sgZBekwNiI2jpX9NeDOANDZB0+667xv2M48wtoHVBXla5izjgCIiIceniKj4dC/
         FniODAkw3LS/XpmlzIE4AgqcfftW3QpOygWiTnH4LQtg72RmnhjCDDM6UxnQn7kYIAX8
         IJSvv8IBRSojXcSARkJjZAdox9JQRCJyR6ONcds7X+RvJf02mp2V0Wz4ZHKR8T/v/Ngv
         Nlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3KjNTpLOPDuLim619IQREZFftn5V2sNi5JTbC4OhKs=;
        b=Lj19c1lqPHUzJQOE+NyC0v8hVyF0lkPf1kv8+BOqUAi1R8T0aJtyGV9J8p/sUVnMGK
         RGb/IDAPMcYh1qqQye+F5T/nhsPCOZM8gcAV9DEeXNu+3rZ9//7E/GKCiXLYISmLunmb
         KsO2JAP9gTyUagVYvExBqwRmAxF21Dj8/2OYGYueoPKksx3vzZ4zgOf71hzuDuYMj+jF
         K5zeFGfBtBeANaPOgL7R45qrvVM+XvnuaJ11c1rcOqZ2IaqhwRpzcAZzcoEy1VZfSJG8
         BuEdqlLnECMA6mgj4ygnCaph+FfFt0kqTPu2Qq8k2oWE06cD5afSzqo9wkRc9ZNaV329
         3eHA==
X-Gm-Message-State: ACrzQf1eqWDUdOLSFHIm+j4egQy0qZ2Fsd9efWsuRy9e7mywI7a+j+em
        OBk6UweCHnL+QaGy6w0I3Ts=
X-Google-Smtp-Source: AMsMyM6Y9+9YPB7sjyEYpZPWYu2r+m9ngLj+jIHtMi7NlH3HJi7ojLT2KGxsWRB76PUTPGabjpRZ2w==
X-Received: by 2002:a17:90a:c56:b0:213:d200:e958 with SMTP id u22-20020a17090a0c5600b00213d200e958mr61045470pje.6.1668103896191;
        Thu, 10 Nov 2022 10:11:36 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bd7b])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79437000000b0056e5f264969sm10393852pfo.47.2022.11.10.10.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:11:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Nov 2022 08:11:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        linux-kernel@vger.kernel.org,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Message-ID: <Y20+1otw2iwldKTl@slm.duckdns.org>
References: <0000000000002473fd05eca7540a@google.com>
 <20221109120415.55759-1-zhouchengming@bytedance.com>
 <Y208VBO9cZ5VL88m@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y208VBO9cZ5VL88m@kroah.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 07:00:52PM +0100, Greg KH wrote:
> Shouldn't:
> 	https://lore.kernel.org/r/Y0SwqBsZ9BMmZv6x@slm.duckdns.org fix this
> instead?

The difference is around whether the id based lookup can see hidden files or
not. But yeah, it makes more sense to hide it.

Thanks.

-- 
tejun
