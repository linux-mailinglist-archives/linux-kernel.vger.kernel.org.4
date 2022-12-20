Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40A6526AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLTS73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLTS71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:59:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415751B1E2;
        Tue, 20 Dec 2022 10:59:26 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id w26so9134215pfj.6;
        Tue, 20 Dec 2022 10:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dBWAV6mPvRgKPCAJVlW6TB8VEgAk8q8OnRK0EpMiohs=;
        b=cDurWDHM8sRetRDZFkI5MeOy9ihnMMpmqsnytFtPLxOpzSNS6GSu2/l7rhHOGOnO1X
         RyL5z2SEXXiA/IWeCS1qwfRJQ6AVBcypZU0+BeEGysouLmMjJkRLZ3weaoElOMtFgIPj
         yswJLxXbtEyRNSLYeuYNTM+egI4t0RQ1ibYoapv10odUIy0sStFI5kbfTsDkmffY7kG+
         tQn5oxGvxGpkA+hMRQ9xl1w+3AttjyjKqzVRYiwAYTBSucIivOA+aJ/ZQDIlTYxYoIW+
         JMhuSwrWoMwBWbjsgXxi/W9eugoTUuDjfuXZ0NQQPJLDGMaaTtKnHp/BJSohWsfblceo
         VIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBWAV6mPvRgKPCAJVlW6TB8VEgAk8q8OnRK0EpMiohs=;
        b=4hmsDTmtOnTn+sronDYd6+tL63CyxJAqkAK81MO8PdoSJip1CWGLCdNHuunOzX6sWF
         8pcZt2xqZPvFTLAiWbemTsitbpOz+fI9uelvrly/Bh+gsBqVVerW30b7Jk0fWfFMXdOM
         MNAguMNnjOqgH7nv/gyYJEQHZo6f4lqGOTmKeCueXdpZCmrjSNt/SQpzTjjL5m2q9PI7
         gbEePHG9q47aWOTKPcWiDi3dAlwX8jVXbW7jvhnlZoWUd/oxisfytFL9fqVlIf4IzR2n
         AwI/b57xtimJYsDJPf08YYtXiF2l67yBECPKMdcDZkFeCK2tsgdCrVnvQJiLeo26suJ7
         gmVw==
X-Gm-Message-State: ANoB5pnPCX76jMUXP+5gQD81F72UZuXmFUecFVGCkaiwkMM0F6i+smUQ
        gWTQoNzKyTzDf4G1Szfi0j/XI6USNJY=
X-Google-Smtp-Source: AA0mqf4kEDgTidFKfZQ0Nxnf0RmG5OCyWuiN2591xupEvfSQGRQ5aeEdKJ7spc7NqXGCM2GlHpt2GQ==
X-Received: by 2002:a62:1bd6:0:b0:578:e56:f57b with SMTP id b205-20020a621bd6000000b005780e56f57bmr42484658pfb.28.1671562765617;
        Tue, 20 Dec 2022 10:59:25 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id y28-20020aa78f3c000000b005774d225353sm8979966pfr.137.2022.12.20.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:59:24 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:59:22 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: fm801-gp - Fix an error handling path
Message-ID: <Y6IGCtw1CHgcBwbB@google.com>
References: <2d4f01f3a721b0dcd34669ab01aff9eddaad53dc.1671485791.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4f01f3a721b0dcd34669ab01aff9eddaad53dc.1671485791.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Mon, Dec 19, 2022 at 10:36:47PM +0100, Christophe JAILLET wrote:
> This looks odd to call release_resource() for something allocated with
> request_region().
> Use release_region() instead.

I do not see why it is weird. request_region() gives you an instance of
"resource" structure which can later be freed. If we indeed want to use
release_region() (and hardcode the length in both places) then we should
also remove gp->res_port member. But I really do not find anything wrong
nor do I want to touch these old drivers...

Thanks.

-- 
Dmitry
