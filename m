Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D170EE79
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjEXGuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjEXGuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C7172B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684910879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oIiB/b0S9/Ju39KPwsWpNKcs/1TJP1qmzsc8y0VhKs0=;
        b=Jre6U4aYwnYM8HH9N2UjDEaLAlZY2e44PBFj08SDCDrKY0BNEcHMG7vArh1+vSbOPm//Rd
        dXN+PTeIaaee0iUfB/twLlGVuESmZWBHfYvShI1lRxfatz3xxMSoC37rVEGC/YWqnH41eZ
        aTbx9wCdbEts+ksXpUYMa1/SB6XJaYI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-g8B_fffPOtKoqp0bHVXHqg-1; Wed, 24 May 2023 02:47:57 -0400
X-MC-Unique: g8B_fffPOtKoqp0bHVXHqg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-625af7de7daso2321326d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910877; x=1687502877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIiB/b0S9/Ju39KPwsWpNKcs/1TJP1qmzsc8y0VhKs0=;
        b=M8LKzbI/VcagqjSHmPRONXZHMbOOFqxNVgXN7LrOxtGVW+uMdwYhYvoMhnCyrnTwee
         XUpkxLvPlkkLsrVPpRaTIN2ZZZK/3tDtyXMpc5F5X/BBliH+i5Rgbx0/1wR6BFqf9kS6
         RWlCNgrvWGJDnhz0MNEkz/N7gwGEELp5bgA2BppRA/fIipeOfwkhzNu/NOXQJEDGMBEM
         0QB7MDrnCU9rzg3NqTnwpmVhJ6FDbystvDzDF/FKktETpt/eLcZA5t/NbPAljmtUUESo
         sK+Sl3BiGi6o2UILbn/hYjzcerqgD9xcjzkrr52TpeZrECppD5elO78MqI8Sk+B3Sy1J
         8RlQ==
X-Gm-Message-State: AC+VfDw1mWblN+eBANDJaE4KoV7CHwSuEwZym+j4C7XDHRJoxmNsL0bs
        7RrneM8SpKsEjhjkC8peQxNycLi/3buAE/V16ebMMTMQuw8Ay6Lu+xKo1L8ZWPsWNoQufRiEz37
        a04uQXOL3wqbGRXPgIqtm8hsk
X-Received: by 2002:ad4:5765:0:b0:625:aa49:9ab7 with SMTP id r5-20020ad45765000000b00625aa499ab7mr799422qvx.59.1684910877497;
        Tue, 23 May 2023 23:47:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4C2RTVjyCXPS0C7lqL/99K1Ac8/Ntm012ZGhP5UJk4X4Z0c64yTnzMaNAIN6dKxH9rxlJ4Hg==
X-Received: by 2002:ad4:5765:0:b0:625:aa49:9ab7 with SMTP id r5-20020ad45765000000b00625aa499ab7mr799415qvx.59.1684910877271;
        Tue, 23 May 2023 23:47:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a26:f801:e31c:7a5b:f5fd:544e])
        by smtp.gmail.com with ESMTPSA id qh16-20020a0562144c1000b005ef442226bbsm3375506qvb.8.2023.05.23.23.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:47:56 -0700 (PDT)
Date:   Wed, 24 May 2023 07:47:53 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: remove unused dl_bandwidth
Message-ID: <ZG2zGaBII1YjKgRG@localhost.localdomain>
References: <20230524102514.407486-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524102514.407486-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/23 18:25, Miaohe Lin wrote:
> The default deadline bandwidth control structure has been removed since
> commit eb77cf1c151c ("sched/deadline: Remove unused def_dl_bandwidth")
> leading to unused init_dl_bandwidth() and struct dl_bandwidth. Remove
> them to clean up the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Ah, indeed.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri

