Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0686C4043
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCVCTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCVCTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:19:09 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A17158A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:19:08 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-53d277c1834so313881347b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1679451548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsGzDD7N3xIQioCZ8vaIzqIq9YbJo7VI7CSEkK+5Bjk=;
        b=iccskpPGlSypcpFSCe6ACliA/LfvS8jKKHNiTJqYMKauomRuO3KAqRJY51xakk1cRn
         2X8dbM0kBrIM1OqZCP9OeAxe9OdH+2J4fUr5ydrF1SWtl8hzduUuwHEwhKHtYv0PmkjQ
         eooelkFcDKR8YQ8XUmxpWMdFQVjqQuoYlkGTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679451548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsGzDD7N3xIQioCZ8vaIzqIq9YbJo7VI7CSEkK+5Bjk=;
        b=AoK70BNf8pjFVgIjRA3j+x/YPodG4nbnNIamIsB8XJZwdk3NBnVC8iYKdF9PxDWsSs
         J6lyjeye8Z/W9Fv095ZfVsBbP14xBJ6IAgY+rtTtsh4yui5BqSQJUzjwkUynjygFHMtu
         4LeqZrqD2ClcEEiUf/MPhLYab6NOqMK858lxs+vrjYT51xyc/vuNOIGhvu6ARAKirPE+
         ucSiy+M2sHsLmrwbZQ/YFvxU89n/1esyC8sa9seuMl61843or389nxnAkIEEnX+fZpzh
         f/dPh63EYCsZwvDfWt0x7H/9ATu7IrUgMZAIdiYUuX/alLT+7pzd7/cdmHANWPtxZr9s
         4lag==
X-Gm-Message-State: AAQBX9ciyxNMt5SFiVUaEZzNktW4DwFb/JiwGYCzCZEGi2X56Tm8TzxE
        /YuQv+TYIRiCwoG1cG6tfbuyFWb309ghyDr/do5Afg==
X-Google-Smtp-Source: AKy350Zx/zVrikbH2Sze2FBliqyAFfVtV5zQypq84Ibep+cu7qoQ+4M54ZZiLEbmGH04pC5+f7pl6MKK/5RGMVX034s=
X-Received: by 2002:a81:b346:0:b0:530:b21f:d604 with SMTP id
 r67-20020a81b346000000b00530b21fd604mr2211123ywh.9.1679451547791; Tue, 21 Mar
 2023 19:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <72ba8619-88cb-4bf4-8232-18d8a1b6b5bf@paulmck-laptop>
 <20230321052337.26553-1-qiuxu.zhuo@intel.com> <20230321052337.26553-2-qiuxu.zhuo@intel.com>
 <20230321154751.hgeppd5v327juc36@offworld> <a4a3e103-78b3-4be3-80b8-bbae7b1bb2f4@paulmck-laptop>
 <SJ1PR11MB61797170867CD7B98CC68BEE89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB61797170867CD7B98CC68BEE89869@SJ1PR11MB6179.namprd11.prod.outlook.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 21 Mar 2023 22:18:56 -0400
Message-ID: <CAEXW_YS_=qCkpKBPfc3o9dnTW2RKNwByZFBDun-KKEDhPy1z3Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 9:26=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Paul E. McKenney <paulmck@kernel.org>
> > [...]
> > > > Fixes: e6e78b004fa7 ("rcuperf: Add kfree_rcu() performance Tests")
> > > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > >
> > > Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >
> > Much better, thank you both!
> >
> > But unfortunately, these patches do not apply cleanly.  Qiuxu Zhuo, cou=
ld
> > you please forward port these to the -rcu "dev" branch [1]?
> >
>
> Hi Paul,
>
> OK.
> I'll be making v4 patches rebased on the top of the -rcu "dev" branch.
> Thanks for letting me know more about the RCU patch workflow.
>
> Also thank you Davidlohr Bueso and Joel for reviewing the patches.

You're welcome and thanks for your interactions on the mailing list
and RCU interest. :-)


 - Joel
