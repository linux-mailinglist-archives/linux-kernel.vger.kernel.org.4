Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E15635A84
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiKWKut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiKWKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:50:18 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4412520F;
        Wed, 23 Nov 2022 02:36:26 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 166812457;
        Wed, 23 Nov 2022 11:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669199783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mooGsozznfonb/nXAwm20lKuZ2SOIf8q5I+sBZvj5s=;
        b=oc5EVEU3GpLmFaip2o70XTljLG54uzphoia06iU4+DcGfmCeioV0OiH+4ry2qC4eM1f6Lf
        7SQczX9aHq+ewsowxCQ1PUxln32yUUnxrz2PusAGy3aq2tT8Egi7p1cv0/NDxratPXL4Zi
        Uqt7WjIs/dXWnXmnOT/8ctsDqLA2nZaMQJnVB9aLU0aFQXMehL0S88ZajLw/H5aHCKkUyK
        RzOuzU98WpmT/iusfa2N1jVi5HXLTycniq24tlBh7yr6Ox/T9g4obdV9sc3tNzGMcMV4Ds
        qlWzRM6nHM89EzL6rhG5dij5Wn5wdAByttnStDz3dThrs95cYM1F9UH9F1Y1bQ==
MIME-Version: 1.0
Date:   Wed, 23 Nov 2022 11:36:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jingchang.lu@freescale.com, tomonori.sakita@sord.co.jp,
        atsushi.nemoto@sord.co.jp, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2 5/5] tty: serial: fsl_lpuart: clear LPUART Status
 Register in lpuart32_shutdown()
In-Reply-To: <20221110081728.10172-6-sherry.sun@nxp.com>
References: <20221110081728.10172-1-sherry.sun@nxp.com>
 <20221110081728.10172-6-sherry.sun@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9c4a8eb97e6566c8a704d69b176d889b@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-10 09:17, schrieb Sherry Sun:
> The LPUART Status Register needs to be cleared when closing the uart
> port to get a clean environment when reopening the uart.

Shouldn't it be cleared on startup instead? What if there was some
kind of event between shutdown and startup?

-michael
