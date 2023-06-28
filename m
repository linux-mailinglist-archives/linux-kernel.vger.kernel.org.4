Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69640740AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjF1IMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:12:09 -0400
Received: from forward500c.mail.yandex.net ([178.154.239.208]:60744 "EHLO
        forward500c.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233316AbjF1IIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:08:55 -0400
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 8BCF45ED15;
        Wed, 28 Jun 2023 07:54:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id NsDSlu5DfOs0-zpDVufAI;
        Wed, 28 Jun 2023 07:54:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1687928064;
        bh=aOLoTVmiFCguShJ+6xSk7vCEfmg/+1Bak/BzwVsTFb4=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=w9obb34EiDOkZWU4JbCFTg0l345qzWF1IhV1xQXxo6sINDic8BcJ4FJzg/aSif/2R
         DuhQ+q5b9qjVGpmju60z6C6IyNcD6UY3JYnCfQnT7UxW09lXxG+/GHYe2jO+mvQxDQ
         SINg9STthfiuPJ4/fSl6n81cNYKV0tufka2cLw/A=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3e7faf02-2724-9d27-364e-eedcd5fc5567@yandex.ru>
Date:   Wed, 28 Jun 2023 07:54:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: plfxlc: Fix possible data races in
 rx_urb_complete()
To:     Tuo Li <islituo@gmail.com>, srini.raju@purelifi.com,
        kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
References: <20230628022121.1010517-1-islituo@gmail.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <20230628022121.1010517-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 05:21, Tuo Li wrote:

>   		if (tx->submitted_urbs++ < PURELIFI_URB_RETRY_MAX) {
>   			dev_dbg(plfxlc_urb_dev(urb), "urb %p resubmit %d", urb,
>   				tx->submitted_urbs++);

BTW, doing 'tx->submitted_urbs++' inside a debugging statement is most likely
a bad idea.

Dmitry

