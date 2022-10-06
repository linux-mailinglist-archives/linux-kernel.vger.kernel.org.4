Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3665F6FEA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiJFVHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJFVHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:07:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3861E3CA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:07:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id g28so3169413pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=5bTBLyGPfmCxkvCIzfZznH2Ifhb8gJd3z2V25tJPiD0=;
        b=dKk8bfqpece8TZo84O+skqcxluLPH+y9y7rV2xLWxGfrjAgtytR3zgHSpZ2ynt5dd4
         HrXCLreff/N1dVyFdxU1ljT97CZnmWHCQvZTLZLzkYIdeTF3nPznmMAv2eqk/v89e/QI
         YSCiqi5GugQ3S4/HoAYp6bqCN8QBAuK3gvvHCvwqwJNuqUTBt7Qx0xMFlC/o5QwuwAeq
         9tzB8Up2piU9iIE1Fm5H68ZtWkt9rU8a3E8nOtRZ322avw10TkgM532X0/Xv9wXjoYxZ
         gvP3ZwVOVGc2C+DydjHAcAKUpMkG9qc+gAQce2h3qJFc8STO4ZtM+Fy6jM8c4rW+1o76
         C9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5bTBLyGPfmCxkvCIzfZznH2Ifhb8gJd3z2V25tJPiD0=;
        b=vb5In98hx4E0/ldnUhOv64MMLS8VlP0wRXjsgpql68vDESfaz64VMoGDiyszTQP/nH
         DFUrshA/meZil3fB8NdHWvk5aDWyATjXyV0pCPtIP2+iG8cX+204STJw5U0yf65/+Jjl
         TQoxTkCQsH19SFH3RvWfAxp9aSNeT6vx0zlTYxYltyJnHGSSe+TYJUXR4x5KgLnNFdqZ
         kKFDgbwOK1PT6iYTiPTfm3eERGqRlRhLTiMLiycPXD6nUxCdyiAMlZY9hSdwYpafUNqR
         SSuGcwgjoHCPTgVCnN3HJf9hEVX8/I7AA0YTMLcsC8sJWE0zAo5qHUt1qGy8lIsmW59x
         Y+Cw==
X-Gm-Message-State: ACrzQf0bbATPLuaVKoclhmzaSAFS0W4xgzWoul6R+hHeAg4q4tDe0HMX
        i6VCdmA7DqWwJAO0Cqsi+Dh2qO2UA87x4g==
X-Google-Smtp-Source: AMsMyM6P/PidTZjuJ1+qQsyjd+J50nx98115Wq9dUPuvR3L5nFtZc04pmmeSWfJ29n8vVG5DiIoMeA==
X-Received: by 2002:a63:fa4f:0:b0:438:e26d:5ec with SMTP id g15-20020a63fa4f000000b00438e26d05ecmr1510069pgk.361.1665090424880;
        Thu, 06 Oct 2022 14:07:04 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090a2bc100b0020a0571b354sm134439pje.57.2022.10.06.14.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Oct 2022 14:07:04 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 2/7] Enable balloon drivers to report inflated memory
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
Date:   Thu, 6 Oct 2022 14:07:02 -0700
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 6, 2022, at 12:34 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:

> Hello,
>=20
>=20
> On 5.10.22 20:25, Nadav Amit wrote:
>> On Oct 5, 2022, at 2:01 AM, Alexander Atanasov =
<alexander.atanasov@virtuozzo.com> wrote:
>>> Add counters to be updated by the balloon drivers.
>>> Create balloon notifier to propagate changes.
>> I missed the other patches before (including this one). Sorry, but =
next
>> time, please cc me.
>=20
> You are CCed in the cover letter since the version. I will add CC to =
you
> in the individual patches if you want so.

Thanks.

Just to clarify - I am not attacking you. It=E2=80=99s more of me making =
an excuse
for not addressing some issues in earlier versions.

>> I was looking through the series and I did not see actual users of =
the
>> notifier. Usually, it is not great to build an API without users.
>=20
>=20
> You are right. I hope to get some feedback/interest from potential =
users that i mentioned in the cover letter. I will probably split the =
notifier
> in separate series. To make it usefull it will require more changes.
> See bellow more about them.

Fair, but this is something that is more suitable for RFC. Otherwise, =
more
likely than not - your patches would go in as is.

>> [snip]
>>> +
>>> +static int balloon_notify(unsigned long val)
>>> +{
>>> +	return srcu_notifier_call_chain(&balloon_chain, val, NULL);
>> Since you know the inflated_kb value here, why not to use it as an =
argument
>> to the callback? I think casting to (void *) and back is best. But =
you can
>> also provide pointer to the value. Doesn=E2=80=99t it sound better =
than having
>> potentially different notifiers reading different values?
>=20
> My current idea is to have a struct with current and previous value,
> may be change in percents. The actual value does not matter to anyone
> but the size of change does. When a user gets notified it can act upon
> the change - if it is small it can ignore it , if it is above some =
threshold it can act - if it makes sense for some receiver  is can =
accumulate changes from several notification. Other option/addition is =
to have si_meminfo_current(..) and totalram_pages_current(..) that =
return values adjusted with the balloon values.
>=20
> Going further - there are few places that calculate something based on =
available memory that do not have sysfs/proc interface for setting =
limits. Most of them work in percents so they can be converted to do =
calculations when they get notification.
>=20
> The one that have interface for configuration but use memory values =
can be handled in two ways - convert to use percents of what is =
available or extend the notifier to notify userspace which in turn to do =
calculations and update configuration.

I really need to see code to fully understand what you have in mind.
Division, as you know, is not something that we really want to do very
frequently.

>> Anyhow, without users (actual notifiers) it=E2=80=99s kind of hard to =
know how
>> reasonable it all is. For instance, is it balloon_notify() supposed =
to
>> prevent further balloon inflating/deflating until the notifier =
completes?
>=20
> No, we must avoid that at any cost.
>=20
>> Accordingly, are callers to balloon_notify() expected to relinquish =
locks
>> before calling balloon_notify() to prevent deadlocks and high =
latency?
>=20
> My goal is to avoid any possible impact on performance. Drivers are =
free to delay notifications if they get in the way. (I see that i need =
to move the notification after the semaphore in the vmw driver - i =
missed that - will fix in the next iterration.)
> Deadlocks - depends on the users but a few to none will possibly have =
to deal with common locks.

I will need to see the next version to give better feedback. One more =
thing
that comes to mind though is whether saving the balloon size in multiple
places (both mem_balloon_inflated_total_kb and each balloon=E2=80=99s =
accounting) is
the right way. It does not sounds very clean.

Two other options is to move *all* the accounting to your new
mem_balloon_inflated_total_kb-like interface or expose some per-balloon
function to get the balloon size (indirect-function-call would likely =
have
some overhead though).

Anyhow, I am not crazy about having the same data replicated. Even from
reading the code stand-of-view it is not intuitive.

