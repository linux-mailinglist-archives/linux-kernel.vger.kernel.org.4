Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B05F84D8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJHLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 07:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJHLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:02:40 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E5342D45
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 04:02:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id D45784077B0C;
        Sat,  8 Oct 2022 11:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D45784077B0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1665226957;
        bh=zamGF8L6C1Cgd0clMmbambwfRNn+iSJ/HOE18n84OjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXPJxQuz10T+MXciIQugvRg61XR+PmieQA8kH/CdqORy+DSbtYzDjdMRpsRev+ylo
         YbQLWq5LfFkFPl46tP9p6oqy/MghdhpBuZboKYtRqIyejl3zv3zRrHNEV6tYGvLW/4
         iPg6cJFjlji38u1+5YBQEmz7SdX/+LXiv837Vu80=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Daniel Starke <daniel.starke@siemens.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Jiri Slaby <jirislaby@kernel.org>,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 0/2] tty: n_gsm: revert tx_mutex usage
Date:   Sat,  8 Oct 2022 14:02:19 +0300
Message-Id: <20221008110221.13645-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3572970f-f40f-5410-651a-a5e019d328d8@ispras.ru>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As far as switching to tx_mutex turns out to have its own problems,
we suggest to revert it and to find another solution for the original
issue described in 902e02ea9385 ("tty: n_gsm: avoid call of sleeping
functions from atomic context").
