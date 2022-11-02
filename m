Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36F616E01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKBTv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKBTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:51:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796B11463
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:51:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c15so5077861qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3DKcNQJ3RVEMM8vP+7GPSWzcDvUtzfV2i4+1GcoEVYE=;
        b=t/YKU2dmdzc3uJKYgMEHvq97DflAJLAihtzWhjZkX3UYffGjvnwWZItD5ig4U9YMEH
         wBiEn9AXWqOzPgT6Hb94xcep1Sh3E6zvqljAjUxQxZA8yRkxefLoVFszdJhUFqIKjsdD
         RHZed6UIzzjo4fcW6h518z1XrlkaPg7IcU0f4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DKcNQJ3RVEMM8vP+7GPSWzcDvUtzfV2i4+1GcoEVYE=;
        b=QYdJVhxmQJTjaaXr/BtWgs7CbE7pgV8YzOTsxI30qRP4LO1XBMCP/pws3QqKOpFjJu
         F62jvEa88S1pPgwItCdfekcPPmcaJ53aPvkYEvG1aVw8ebQ6b74AYSHa0OVmziNf8htI
         U0pREb/zLnQo6ejit6YqFz0vk8N5F+NCVUImjg8kuLKC1zLx7esMUzil9eLgXaiAHlvw
         UeeEapYmih2Tr7oP0qf3RjCS2cFnfPb9jg7rXUFmcgGQYPj7yzdKrIPzXOxGf23TdFve
         vKSoCsjnKp+8DA8/RaiIxeapLUrhExcNcRk1iLxZL2WohEdtCHztR1SdYFU1dyFAm20D
         Y/ig==
X-Gm-Message-State: ACrzQf1jd8WWs8xuvddEuJKjX+nt7VQysi/MxYIeZrWB1lDDiPXXNIba
        7xF+gna2PFDva9OChhWRmqx5aA==
X-Google-Smtp-Source: AMsMyM7upmT3EwxwMAmeY2BOX7RVYtPqaPk4aHLcnlD09U86cii2ogN6TWpJxWcZuXadk4MC9OhUMQ==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id o2-20020ac85a42000000b0039d136e8a43mr20991571qta.372.1667418710987;
        Wed, 02 Nov 2022 12:51:50 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bj41-20020a05620a192900b006f7ee901674sm9159593qkb.2.2022.11.02.12.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:51:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] rcu/kfree: Do not request RCU when not needed
Date:   Wed, 2 Nov 2022 15:51:49 -0400
Message-Id: <ED8E1017-A219-4815-BA28-5F44A2FB8FF2@joelfernandes.org>
References: <20221102183237.GO5600@paulmck-ThinkPad-P17-Gen-1>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102183237.GO5600@paulmck-ThinkPad-P17-Gen-1>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 2, 2022, at 2:32 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed, Nov 02, 2022 at 06:30:24PM +0100, Uladzislau Rezki wrote:=

>>>=20
>>> to wait for a GP. Or if the poll_state_synchronize_rcu(oldstate)) !=3D 0=

>>> queue_rcu_work().
>>>=20
>> A small fix. If poll_state_synchronize_rcu(oldstate)) =3D=3D 0 then
>> queue_rcu_work() since a GP is still in progress.
>=20
> Both get_state_synchronize_rcu() and poll_state_synchronize_rcu()
> may be invoked from interrupt handlers.  And from NMI handlers,
> for that matter.

Thanks for clarifying. I meant to say cond_synchronize_rcu() cannot be calle=
d from interrupt context, but I made that comment before Vlad cooked his pat=
ch.

Thanks,

 - Joel


>                            Thanx, Paul
