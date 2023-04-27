Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23D6F07A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbjD0OkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbjD0Ojw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573530D6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682606342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n38a/ap8JEojwB1X8Ga+6cVJFz2FjJPXkJ9o2gq99yI=;
        b=BJOZzRtXCqfsNLxTCaVfguAC2Nl9N6VKBmCsmswR6dIQMwAxWBG37bmxzGjP7QKQ0wdGQ1
        D9LKqBJT6ERCoN6IDPv5jyddyh3SPfV3+5sB7soqQpL8PBTGE1eXAadNyghDecO6zwGQ0b
        w5zrF2GLrryz3xGZHGgYsaCWEt+eMdk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-E4501H05Nui5SyCf6jpQQQ-1; Thu, 27 Apr 2023 10:38:43 -0400
X-MC-Unique: E4501H05Nui5SyCf6jpQQQ-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5464cf41fbdso5727228eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606312; x=1685198312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n38a/ap8JEojwB1X8Ga+6cVJFz2FjJPXkJ9o2gq99yI=;
        b=ERD5UN9JM+wBmVZpsInFToS/UJB1ZecqxQNb/yKBaA/X52celS7wgD0cCp2l59ZvPZ
         R/w/CHMvRgTjEe2D03JKUen5PJjoeA2AHRyWIKo4pr5/aHSlIG4AHLSPWEbiryur3iUY
         T175bagywIkpzwClncSO7jILqwwhyYgZ5Owvmji9rPcb77gJa1Yl7S8ywyc6LMYEpm6Z
         x+bMMC6qvZnIaC5+BpBMjpK98hTRludEeJNazZspAH6yplPo9mP1OYR5By0DB645+hkX
         Xh2FMlWlJaCaQzwOo582sh4A6fb7Oi6ux8pDT1PhUufWBdr1xkJ57Qmya0SoJuY694sO
         gnLg==
X-Gm-Message-State: AC+VfDz4hWak+dVQtxtAgrI4vB5l88LCOE9cyiTYQtwxF60AyfpSqeY7
        ZQT4VIQkNzuf89LRgosY0LxOtNHV1g8WitT0UW0e4FQPmQQiEE1BChe1XiYtJo09v9rPPbN/qas
        aP8ZaSCJp0w3yCmVRnM9wPGHl1NpBbLEsMB5CEMQA
X-Received: by 2002:a05:6820:502:b0:547:5593:d6 with SMTP id m2-20020a056820050200b00547559300d6mr1327448ooj.5.1682606311908;
        Thu, 27 Apr 2023 07:38:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C8xnwX/1ZRGPFzQnse0x6PxyxWI9ZUENosmWDrP95UdVMWcVgBQdD9vv1aM8F2y4SEzeyrs/y39WXiyX3poY=
X-Received: by 2002:a05:6820:502:b0:547:5593:d6 with SMTP id
 m2-20020a056820050200b00547559300d6mr1327440ooj.5.1682606311705; Thu, 27 Apr
 2023 07:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230427101241.1273752-1-costa.shul@redhat.com>
 <87ildhfobe.fsf@meer.lwn.net> <CADDUTFwGHytziCux07cXO0eYDUXYh3Scp=Qm96N+1wAX3ELDeg@mail.gmail.com>
 <87a5ytflht.fsf@meer.lwn.net>
In-Reply-To: <87a5ytflht.fsf@meer.lwn.net>
From:   Costa Shulyupin <costa.shul@redhat.com>
Date:   Thu, 27 Apr 2023 17:38:20 +0300
Message-ID: <CADDUTFzkFmY9y=Yr5mbyGNF4mY4LOJyTe159UT+NhmTV8svsZQ@mail.gmail.com>
Subject: Re: [PATCH] docs: redirect from old arch to the new one
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> is there an actual problem needing to be solved here?

There is not an actual problem. Only a potential.

Thanks,
Costa

