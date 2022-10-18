Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27716035D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJRWZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJRWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C6E419B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666131906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a5wbRvkgVk+UwUXSQmQAJ6lHDYoVbJsomLH7rHukjlk=;
        b=GLyMHWApSXoHNz8V/ShnGTB3WZ/eloqqqPUGg0g+dTFvWTF4RK1z6ZIo+vQGfIbpIexLhw
        246xffA0qKE20oZiQOvjvro5grL/cN0sPc/vJOYwhdiZl80CQD0XZxkCjor1zL7SzvCv0b
        CD0RL+iEyLH1P56Cg+QOvOpdaNgEgD4=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-WsFSuZElOfe9ZlWF-D747w-1; Tue, 18 Oct 2022 18:25:05 -0400
X-MC-Unique: WsFSuZElOfe9ZlWF-D747w-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-355ece59b6fso153847907b3.22
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a5wbRvkgVk+UwUXSQmQAJ6lHDYoVbJsomLH7rHukjlk=;
        b=Hy3drfy4vRcom5xFMrlB2RXeFs52SnhHewmKgl1nghszVkj9DKpOZMwoXWm074RtOz
         1/p9gVH7fCIZBCgqse5b+qmzfuiCPsBPArladicmm5eJmMbN2zXj3mK1vfUu6UnghHUU
         97rgB5RKRDUL1cHOBIF9ShBbQUrlQj7iBK8ct4zNxuNLHtCCAPfD5n0E3R0eMDXzxlm/
         yNX/vdzh9X5xK8mySpAHG69nNkvpSgAo1m/ECWkgUgP3Mx0aK9POiglOAfpUytk3Wuf6
         AE9/UIgXiHMiltiUvRYVhwj0GW8AVsyFuFcjs4lOpnMVJiPnlJcY7+WaZ1Yked1lhXKH
         rR0g==
X-Gm-Message-State: ACrzQf0HKQeGR3AQ5Ih/MLLkNr7x88TZcgbKrIl5OU6SygDbbA/hbK5r
        I7ZoDbGz6mHjtpzjCKLrKZKKeVEejCNEx0ToKd2QEqKgUjxUc+HtFtuTmi3k6rK+6W1UaRTIFnm
        DHOmkY2ML4DLRlpGPKWZyoW71xdXRsY/xPuqpDFh5
X-Received: by 2002:a25:ca15:0:b0:6be:b45f:770a with SMTP id a21-20020a25ca15000000b006beb45f770amr1956965ybg.130.1666131903279;
        Tue, 18 Oct 2022 15:25:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7luNnDmhEyzoV5WogOXajm+rjxHlqOQjgMLzp1YbzvuCmZY+/kxXzVdhAAOVGZR7JUJb5w4YdL3GzEImx/O3A=
X-Received: by 2002:a25:ca15:0:b0:6be:b45f:770a with SMTP id
 a21-20020a25ca15000000b006beb45f770amr1956954ybg.130.1666131903077; Tue, 18
 Oct 2022 15:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221018183021.1832032-1-jsavitz@redhat.com> <20221018151145.2997697f0251e3cb419e09ac@linux-foundation.org>
In-Reply-To: <20221018151145.2997697f0251e3cb419e09ac@linux-foundation.org>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 18 Oct 2022 18:24:47 -0400
Message-ID: <CAL1p7m5YRdOasXJG4Q-qOK=O8EQQAmNVvveGy+9DzVzN_jMVCA@mail.gmail.com>
Subject: Re: [PATCH v6] selftests/vm: enable running select groups of tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-next@vger.kernel.org, Nico Pache <npache@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok sure, I'll give it a go.

Thanks for the feedback.

Best,
Joel Savitz

On Tue, Oct 18, 2022 at 6:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Oct 2022 14:30:21 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
>
> >  tools/testing/selftests/vm/run_vmtests.sh | 212 +++++++++++++++-------
>
> Lots of patches change this file so I can see I won't be liking this
> patch :(
>
> Can you please redo it against the mm-unstable branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm and we'll see how
> it goes?  Thanks.
>

