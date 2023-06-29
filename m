Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1CA742134
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjF2Hli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjF2Hkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:40:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6229B2117
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:40:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f96d680399so583859e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 00:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688024444; x=1690616444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aCvItk4u8Xw4TPc4spMvCXobxSAA3eABPXjHkYAUpLk=;
        b=mGf5J/U72KskTBIYc6xsE9KnE4nZCSfHfaoTTDt85NgfJtcCMtgNgeT9haMrujqxha
         MVaMXAYvpRCJbTMoANxKq9pYcjI8IvJY5GkDxhe2bIWzjeqslPn/tpHZXm0xE5cIk8vk
         UYb/b1vYxLWqOv0CkVLMIg31iwRPNIkUYNkdoLM9PJykYRM2t8vgE+7aVIaj+H3iGlvi
         WJu96c6ucRVuH3SINQyvbopFrMPzAjQ9eUdR+7LvIV5J051qPSdxJ5lhPt3L0pN6tA5x
         RTuA+Mo7Ugv0rp6Jgn3Ul5qnfIs7Vnmvz1fbfztoCc8RZHQhXbSHtfpFGdwMw0tKHfxj
         rhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024444; x=1690616444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCvItk4u8Xw4TPc4spMvCXobxSAA3eABPXjHkYAUpLk=;
        b=hsKQz5fjtdL6fHfLbHxCEa7rRpY7MJ1myVJfYcAsWD3Xeaz4wcxkeEXkVzDZ1Yy6+h
         6pVHJuiLoG4Ii0XN+tECiQBlqL7FG0NCQupBusccPDBgzP07a5PPw9KB9GBK52m2Pkp1
         9rp4hiLI94tEnEbDhC/6JF6nqv+jVlnMwqQ2hNpgmXC2KaR+PbqG0z3burrPndJLuySc
         PmUKAkVfVHQoQuTRuO9e26rGuq1EcI6U1ZUYyVGcdTPfyS+A/tpwIisgVGIl2CDa+1V1
         VttYo+NlngtCQZFv8Q9eXIGOKhZT8/3UW+h4fiB13ltmYng0eczaCPvagKP/gel03/9C
         QcaA==
X-Gm-Message-State: AC+VfDzGRHNUqao86cQ28i3/QW58hnMUJWusG9sd0lOTmpenPmNdHlD7
        rk2E1sXSW3rY0a8j0vyivC6khQ==
X-Google-Smtp-Source: ACHHUZ6doX7XGPh1+1+eyZ2/srAvhhvcgcZPj05VEWkTdYaXdBArzu//8SA5d8E51LReLnOtU4E8ew==
X-Received: by 2002:a05:6512:2348:b0:4fb:897e:21cc with SMTP id p8-20020a056512234800b004fb897e21ccmr5582764lfu.67.1688024444614;
        Thu, 29 Jun 2023 00:40:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c7414000000b003fa973e6612sm10644148wmc.44.2023.06.29.00.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:40:43 -0700 (PDT)
Date:   Thu, 29 Jun 2023 10:40:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Franziska =?iso-8859-1?Q?N=E4pelt?= 
        <franziska.naepelt@googlemail.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        eperi1024@gmail.com, hdegoede@redhat.com, quic_vjakkam@quicinc.com,
        johannes.berg@intel.com, tegongkang@gmail.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 0/3] Fix some checkpatch issues
Message-ID: <69a90f88-634a-4126-8d33-e770fcc4b686@kadam.mountain>
References: <20230625155632.32403-1-franziska.naepelt@gmail.com>
 <7caa96fb-4fb6-fb87-5d0c-fa6985fa127b@gmail.com>
 <CAAUT3iM7eAYH5AcN=Ko9jDstEUGqXxG7Q6qjp4O9qF_e2WkUVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAUT3iM7eAYH5AcN=Ko9jDstEUGqXxG7Q6qjp4O9qF_e2WkUVQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:38:03PM +0200, Franziska Näpelt wrote:
> 
> Do you want me to submit v4 to fix the email address as well as the subject of
> the cover letter or are you ok with me promising to make it properly the next
> time? ;)

Philipp is not the person to ask, it's Greg.

Yes, you are going to need to resend because of the email address thing.

Probably the cover letter is not a reason to resend, but since you are
resending then please fix that as well.

The reason why we insist that you resend is a couple things:
1) This is a checkpatch change to staging so we assume that you're just
   doing it to learn how patches are supposed to be sent.  So this is an
   educational opportunity.  ;)
2) Greg maintains staging, usb, serial and -stable.  He's super busy.
   It doesn't scale to hand edit patches.  Some maintainers are less
   busy so they can fix trivial stuff like this but in staging you will
   need to resend.  Also if it were a security fix maybe I would step
   in and help you fix your patch but since it's just a checkpatch thing
   no one is going to edit your patch.

Right now the merge window is open so Greg isn't going to see your patch
for a few weeks.  When he does he will press the button on his keyboard
which sends an automatic reply about the email address thing and deletes
the thread from his inbox.

regards,
dan carpenter
