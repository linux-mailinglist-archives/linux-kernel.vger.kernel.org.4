Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0968ECA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjBHKSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjBHKRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:17:51 -0500
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBC8474EC;
        Wed,  8 Feb 2023 02:17:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675851431; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=a9pTBHkzi3977WZY74JBHfsI/z2o77LviYEDNpD3MiFubPyiGyfYHVoTGvJ1/9nOmSpp816OeZ+LGG0DqLr/2iCwT+jDJVDrag4w7SQI44RJ8PhdIlbB8EuohUdiQ/HFQn3l3CDaH0L8yVkHn1EmdQDlmUuLNMWh0PSwxw8/6NU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675851431; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LHJyQMkNNcunTmIH0OdbDM+lgp+BZFAk5nq7/5YFCPI=; 
        b=USgOhlC1ZaZaQVIW8AMQVC+xFqcl31b64Kor8umucmIMZpSH5kT9xhxHKwgDKFq4SLcc816HOtw3LUvMSgQzLtUg/XBBrUBUXVpHaw65nULZG0IWFBlQh35vKzbBdRAsVgfFA7Bd0rhcysbbi177Y7UophqmLtwKyurAlkwLKD4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675851431;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=LHJyQMkNNcunTmIH0OdbDM+lgp+BZFAk5nq7/5YFCPI=;
        b=TgVFauA65Rcm3FAomkLL7PsaqjuOT4pdI+NGg2hqh5yxFhpZe31yOCf+lGUojabX
        6mnmCMmGehXNUQ9mhE1yPhyhuwR2JxZk5gJ0TiY2PSNKQXoyizCPUiIGM63QCgqIrcD
        B+90m2KiZ4EwmA6ToMNjmvGiAjG6e48Join+hzWA=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1675851429664397.45521915120526; Wed, 8 Feb 2023 02:17:09 -0800 (PST)
Message-ID: <399b1e82-2eb3-127b-6a09-12872b5366fb@arinc9.com>
Date:   Wed, 8 Feb 2023 13:17:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/2] nvmem: brcm_nvram: use buffered nvram data for
 cell values
To:     Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675717472.git.wdehoog@exalondelft.nl>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <cover.1675717472.git.wdehoog@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Who's going to take this series?

Arınç
