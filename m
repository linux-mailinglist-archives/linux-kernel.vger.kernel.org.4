Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC69E6E5C80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDRIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDRIul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:50:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D735B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:50:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681807838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfWkS+6bHpyyUE5vMA2TpePtx+jFRn2Uph6zqV5toCw=;
        b=p3AAYtJpDTgLq0BAw1c9X7g9p7BoGcsfI0iAx8XqmolfkzYq5FD8kPNc+/4RR1DnAEJhfC
        i8q/r0PK0+w3x97RsWIkjamGHfKx9vRskeEd1wKjZYSSboENZjv5PpEbmOKjqUylZLN7LS
        xJRQ3fiPgclGnpyjDN89zp7+kgCdTnNVZItpzUqEZXBodSZG3qdC7jCK7oXeNPemcIrQRO
        f6JFmbhwOeHuL+874HA+tI9pR0hd+NwcqslzGjvFJy1tSanmmflib1U1yxkursf1BLGwkO
        AwBEBbQao/4lWtPhKg1O8NtVeH+TM3smQyyuGonDxm4dXwF2PXGDW6XA6U6rPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681807838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfWkS+6bHpyyUE5vMA2TpePtx+jFRn2Uph6zqV5toCw=;
        b=waq2njSse8g6BDk5lwlAYWE+wAuVslLow7mRWj2DXqkxy6qR6HoK5wX+l2o0RZ/fj7Iodx
        7xLPtXKoFaU7GMCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Victor Hassan <victor@allwinnertech.com>, fweisbec@gmail.com,
        mingo@kernel.org, jindong.yue@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tick/broadcast: Do not set oneshot_mask except
 was_periodic was true
In-Reply-To: <ZD1fdvr1Eh8aAdnU@localhost.localdomain>
References: <20230412003425.11323-1-victor@allwinnertech.com>
 <87sfd0yi4g.ffs@tglx> <ZD1fdvr1Eh8aAdnU@localhost.localdomain>
Date:   Tue, 18 Apr 2023 10:50:38 +0200
Message-ID: <87mt354lr5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17 2023 at 17:02, Frederic Weisbecker wrote:
> Le Sat, Apr 15, 2023 at 11:01:51PM +0200, Thomas Gleixner a =C3=A9crit :
>> There is a second problem with broadcast device replacement in this
>> function. The broadcast device is only armed when the previous state of
>> the device was periodic.
>
> Any chance the patch could be cut in two then?

Let me try.
