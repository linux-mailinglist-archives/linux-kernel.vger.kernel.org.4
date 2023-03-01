Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB06A746D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCATql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCATqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:46:39 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392EB4DE02
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:46:38 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so15739439qtv.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 11:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677699997;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnvIt78BkXNn6ES/Xg+N3YBtCXIuWCANKtdz23oKbXI=;
        b=qWw+wQdwBu2zgUFXAmjBOSFeTHaHbLbY5I9APi+FWEmGvXqUV3Chq8DwyfqBTc0YUE
         hW11YqBhjv6RSWVKptpV0NzTxNYnpOJ+UPntZQ0+if+FLDvRFpH/JppLEIDBGF+Aydtn
         XZ9g/qkiOcnqDnVHZMOqtuRKvXePaXgAPl6NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677699997;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnvIt78BkXNn6ES/Xg+N3YBtCXIuWCANKtdz23oKbXI=;
        b=BsdFMRRxvz9+Wmo8CiexRVfsRSHLAfo3O5zs0gCaRE0UG4yc+me6StgQbgd1fWTwJH
         lvEjmbM4nbw/UvwA6XcyesQXXwrFIXYlLBonDIkvtFFlQ0lU2RzzdeGJu9Cx4ko4QMpp
         8MBZYCgVhKdZUK0wLEnF1HG8fra7fG8QOg1tS0Z17O3RqMxzfAp1Sm/6o02gZRMY84UE
         dc5OOPwFhz67Sm53NmEZvc/Dk0jDXYCKEfftidacoirNMY9/qt/tQVBoIzl+5NIzUdWh
         HINLr3VT510pIP08hKNq8IFLQmJ1G4noMbmV/oJCy+sl+Ve/Us6GKVyxj0Q8DqXazHA6
         fI6w==
X-Gm-Message-State: AO0yUKV60qdRVcT5ERYX1WQI+fVpT6kZjmX93rj+Fki1hHEWskVN8vXJ
        zE5V0ZP+NgB++ZNMtcLN0BPsVQ==
X-Google-Smtp-Source: AK7set8530PN2IyZ4cloMMqOhB+OVlKK3v2iELIcLzylgqLAPtxWT4edodd3ImfyrXG/lT+MN+eO2g==
X-Received: by 2002:a05:622a:1a95:b0:3bf:b614:bcba with SMTP id s21-20020a05622a1a9500b003bfb614bcbamr12853575qtc.42.1677699997183;
        Wed, 01 Mar 2023 11:46:37 -0800 (PST)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id w9-20020ac87189000000b003b8484fdfccsm8853483qto.42.2023.03.01.11.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 11:46:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] rcu: use try_cmpxchg in check_cpu_stall
Date:   Wed, 1 Mar 2023 14:46:25 -0500
Message-Id: <00F4E7D7-6E54-4BC0-9735-4038F8DBAE20@joelfernandes.org>
References: <20230301144355.338c62de@gandalf.local.home>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
In-Reply-To: <20230301144355.338c62de@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 1, 2023, at 2:43 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Wed, 1 Mar 2023 20:18:11 +0100
> Uros Bizjak <ubizjak@gmail.com> wrote:
>=20
>> If we want to put the definition in generic headers, then we also need
>> to define acquire/release/relaxed and 64bit variants. ATM, we have two
>> sites that require this definition and I think that for now we could
>> live with two instances of the same definition in two separate
>> subsystems. But this would definitely be a good future addition. There
>> is some code in the form of
>>=20
>> if (cmpxchg (ptr, 0, 1) =3D=3D 0)
>>=20
>> that can not be converted to try_cmpxchg, but can use cmpxchg_success.
>=20
> And even modify code that uses temp variables. For example, where you
> modified the ring buffer code to use try_cmpxchg(), I could convert your:
>=20
> static int rb_head_page_replace(struct buffer_page *old,
>                struct buffer_page *new)
> {
>    unsigned long *ptr =3D (unsigned long *)&old->list.prev->next;
>    unsigned long val;
>=20
>    val =3D *ptr & ~RB_FLAG_MASK;
>    val |=3D RB_PAGE_HEAD;
>=20
>    return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
> }
>=20
> Into just:
>=20
> static int rb_head_page_replace(struct buffer_page *old,
>                struct buffer_page *new)
> {
>    unsigned long *ptr =3D (unsigned long *)&old->list.prev->next;
>    unsigned long val;
>=20
>    val =3D *ptr & ~RB_FLAG_MASK;
>=20
>    return cmpxchg_success(ptr, val | RB_PAGE_HEAD, (unsigned long)&new->li=
st);
> }

Nice! Looks much better.

Thanks,

 - Joel

>=20
> -- Steve
