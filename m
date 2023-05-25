Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D1A7108D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjEYJ03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbjEYJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:26:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1CA9
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685006738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TswzAacTiRxyVP+Y7gLK2/PWJAMEsT26lk8noEPtki0=;
        b=UFLpZ78j+7NErWH6cadwQvUibRNdbSXJfqEU9yz5t184HMa23F89ISF/Cs3G5C1fM7DJTG
        15YKwKRk2MLIqzDtis2qUnKQWQF4iqT3Hkue6gjtZU9T3TXseqwVVezz0rLUgs1khLoAER
        1rrbCXG4RV88YdCy0lqoQzflpF5YXCU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-wYicrjUWOYCLKDBBOZJYlw-1; Thu, 25 May 2023 05:25:34 -0400
X-MC-Unique: wYicrjUWOYCLKDBBOZJYlw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f7d72d552fso1705951cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006734; x=1687598734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TswzAacTiRxyVP+Y7gLK2/PWJAMEsT26lk8noEPtki0=;
        b=PQPPJAkBRpCqqH8BexSGJsP6wZzfs9M5+6yB7UWi1O4jirm9M0KxbkXAYxIKvXFm+s
         iLscCT7LoVnPWUWtaRtNk5ht1KVsbLgfg/0haw9dWpAE1ztxFXKBLVIQy6NPGukAGkQj
         VTGqClH/tlftaZmPByjdyXC3UCYMkCj5/o/X0eAXepMURQ9nSjMkOAoecwoN3elMkVTZ
         Dj0CjHSWiZdgYsjGF84dmyNRTa021uKNrvZi0mE+WZ5DeoVhAUwx46bcz1cFI8yk7tkn
         X3/TkVkoWBjNP14TngfTTr5uF8g/gmCLzol2pVMS91yZK0YTruJuvA1KpM9M9jDra/PT
         xZsw==
X-Gm-Message-State: AC+VfDx6E/U6xQ7jeVlwnYh82A+Hhr2C6MjRtwDDc0KBuoiirrsXyqlo
        dLdvN+zRkBHC6RLClCg86zPOoPF3lQbE1gCOnuvQCqU4S61pXG0FM1S9dBuooP35guRSXBs8xJu
        fIjjSs+Ncyz/3tYkHlFG2SfMS
X-Received: by 2002:a05:622a:1802:b0:3e3:c889:ecf9 with SMTP id t2-20020a05622a180200b003e3c889ecf9mr6254243qtc.1.1685006733905;
        Thu, 25 May 2023 02:25:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6C0uo6zmsXIIx0EZAwr4i+mHtD7VlY7p338AZO4X3ALId/lstT+GC16SI9wyZr4AiQo1SrlQ==
X-Received: by 2002:a05:622a:1802:b0:3e3:c889:ecf9 with SMTP id t2-20020a05622a180200b003e3c889ecf9mr6254226qtc.1.1685006733680;
        Thu, 25 May 2023 02:25:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-207.dyn.eolo.it. [146.241.242.207])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84a19000000b003ef3129a1a6sm261918qtq.46.2023.05.25.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:25:33 -0700 (PDT)
Message-ID: <c536fcd795f74016928469be16fe21df8079a129.camel@redhat.com>
Subject: Re: [PATCH v5 net 6/6] net/sched: qdisc_destroy() old ingress and
 clsact Qdiscs before grafting
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Pedro Tammela <pctammela@mojatatu.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Vlad Buslov <vladbu@mellanox.com>,
        Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Date:   Thu, 25 May 2023 11:25:29 +0200
In-Reply-To: <CAM0EoM=T_p_-zRiPDPj2r9aX0BZ5Vtb5ugkNQ08Q+NrTWB+Kpg@mail.gmail.com>
References: <cover.1684887977.git.peilin.ye@bytedance.com>
         <429357af094297abbc45f47b8e606f11206df049.1684887977.git.peilin.ye@bytedance.com>
         <faaeb0b0-8538-9dfa-4c1e-8a225e3534f4@mojatatu.com>
         <CAM0EoM=T_p_-zRiPDPj2r9aX0BZ5Vtb5ugkNQ08Q+NrTWB+Kpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-24 at 12:09 -0400, Jamal Hadi Salim wrote:
> When you have a moment - could you run tc monitor in parallel to the
> reproducer and double check it generates the correct events...

FTR, I'll wait a bit to apply this series, to allow for the above
tests. Unless someone will scream very loudly very soon, it's not going
to enter today's PR. Since the addressed issue is an ancient one, it
should not a problem, I hope.

Cheers,

Paolo

