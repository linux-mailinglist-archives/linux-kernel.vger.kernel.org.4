Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAAC6BD0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCPN2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCPN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:28:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D4B6F48F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:28:43 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r5so1636128qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678973323;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mq05T+mqYchdO6eVgaCmPyYAruAZx/QKv/nYoCC7GvE=;
        b=gtIvtqKZjbnizmS8t3q0lgTHjhzQuSiektGAU7yoNCrCEGjyt74+35bI9cf/AouYOg
         i9q2/s2WPzwpd10R0HLiYLs9GXw2M8MNKrIspd2LMnciGoj/JjZAgoWmSVO2GCZIwR4N
         whaHxtw3NlKu4M3za5UQkxHLEkj1CzxdB+Yrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678973323;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq05T+mqYchdO6eVgaCmPyYAruAZx/QKv/nYoCC7GvE=;
        b=jhh4ICQzB6G75Pap/YblzhPjIoN87bP8HssFoSfx93ezo7nTcoLh6IE+cUSwjwik+7
         zuA2GKfHLZOJ7DTrmPlPoPGnOCqPqen+pteUrgbeu0Xk4P6bvFGfSmbp6hnGAVTgqWZO
         WBghdO1qOyPyviWE0IAas9S+uqMZNmNWaPC90DzWzh6eFsmahCTAx84qthOJRZBogK5x
         zWFn8BFegZ/AZ+/cJlyEZGyP+yDvPCNNLeXfDW2RGvTSj3MGmWDQL0J6qoDvZGC9cDC9
         zgVMVpHtNkQNZnxJpTBYejn/36+HL4b05sVNo1QJuTTNqtQqtKkUV99bKhmn7NO+UsEI
         4oeg==
X-Gm-Message-State: AO0yUKWBuJ6fN34leYr8vkqKbWbRbyT5letpcB5UGyCLKFP8HLZt8YVm
        +aGlETMZunM1mzRfr5XaCwmgtExkGhUjvpHHmZg=
X-Google-Smtp-Source: AK7set8shGyWYizyY6RNgWTdQAw4vWEX0VNS0sxE9of5pEe8x9LdR1zyuafDT2JKIuNlsh1wANUj6g==
X-Received: by 2002:a05:622a:14cb:b0:3d5:1fc6:587b with SMTP id u11-20020a05622a14cb00b003d51fc6587bmr6471346qtx.18.1678973322822;
        Thu, 16 Mar 2023 06:28:42 -0700 (PDT)
Received: from smtpclient.apple ([2600:1003:b840:cfc9:d51f:7877:7172:21f6])
        by smtp.gmail.com with ESMTPSA id de21-20020a05620a371500b007422fd3009esm5994590qkb.20.2023.03.16.06.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:28:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale
Date:   Thu, 16 Mar 2023 09:28:31 -0400
Message-Id: <2B9F2C1A-B274-41EF-8ABE-1E660521BCE4@joelfernandes.org>
References: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
Cc:     paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <IA1PR11MB61714FEEAF2C46639891401A89BC9@IA1PR11MB6171.namprd11.prod.outlook.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mar 16, 2023, at 9:17 AM, Zhuo, Qiuxu <qiuxu.zhuo@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> From: Paul E. McKenney <paulmck@kernel.org>
>> [...]
>>>>=20
>>>> How about to pull the rcu_scale_cleanup() function after
>> kfree_scale_cleanup().
>>>> This groups kfree_* functions and groups rcu_scale_* functions.
>>>> Then the code would look cleaner.
>>>> So, do you think the changes below are better?
>>>=20
>>> IMHO, I don't think doing such a code move is better. Just add a new
>>> header file and declare the function there. But see what Paul says
>>> first.
>>=20
>> This situation is likely to be an early hint that the kvfree_rcu() testin=
g should
>> be split out from kernel/rcu/rcuscale.c.
>=20
> Another is that it's a bit expensive to create a new header file just for=20=

> eliminating a function declaration. ;-)

What is so expensive about new files? It is a natural organization structure=
.

> So, if no objections, I'd like to send out the v2 patch with the updates b=
elow:
>=20
>   - Move rcu_scale_cleanup() after kfree_scale_cleanup() to eliminate the
>     declaration of kfree_scale_cleanup(). Though this makes the patch bigg=
er,=20
>     get the file rcuscale.c much cleaner.
>=20
>   - Remove the unnecessary step "modprobe torture" from the commit message=
.
>=20
>   - Add the description for why move rcu_scale_cleanup() after
>     kfree_scale_cleanup() to the commit message.

Honestly if you are moving so many lines around, you may as well split it ou=
t into a new module.

The kfree stuff being clubbed in the same file has also been a major annoyan=
ce.

 - Joel=20


> Thanks!
> -Qiuxu
>=20
>> [...]
