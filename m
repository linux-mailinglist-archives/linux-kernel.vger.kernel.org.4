Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF536BDA17
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCPUYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCPUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:24:07 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76810ABE;
        Thu, 16 Mar 2023 13:24:02 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D76675018FF;
        Thu, 16 Mar 2023 20:23:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a290.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5734350182C;
        Thu, 16 Mar 2023 20:23:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1678998238; a=rsa-sha256;
        cv=none;
        b=bQKVpHHOuPOR2QMouvhzR4jlckVrG7UYNYmHgdjpAQk534RDX5EjkTACfUn7G72zyfSBe+
        WwfBtfQVZBX6m6shd58J7iHz1CCHhLwi+OaP/c0jFyC/U8EmOSGwzGXsTBtOmGLOvA878u
        H0I2LIYXSFfZS7rivdiHfdIRmYUhTQwdu4yJi+gTK6EjyAOnlns/eEra+YNGgY2j3zWNiK
        yH/TsFUXbwv8TMfmhPH1VtytaoV9A5EXWVB/suluOZ2T7+ZN+NusKUIX+swqDU/zTLAfs2
        fX9lgSff0dA4EveG1I/0zzD0x2ev6Z3j1yL7ud+inqJIFKMWwmKjqmsZj6waWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1678998238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zzZZTZnF4mgkGlPMN+EAoe0gpBwte5d92YbdLcYCzn0=;
        b=j95Agn9HTQzQConAUf/37EsGDrhUiYyg4G2YTg1ZThqvoLHPm+ZBSemuXXDo5l+VPQu3eZ
        5P7OycDbQ+JUoJ2xRCn4a4ZRfpZoG0RTQHNkEeMFwMKO9koZcgOkYkKAaGo1SweqyFwFh3
        UYlJNg4LZG8h9oCCqP/jmwOU9S6dW6lU/Ainc80L8bG0mSHyBxINgisiwrRKsGo3hLXpVe
        kwsV64Bq0wIkimVJZImtGAPXNs8445vVnqRlwKy2yp5q+Oa+0PF9Od1LbP7WevdIZG2fSW
        nac8cEmJzYcqOfnhxopZESr1pB2r41IJpmRKgCWSA5Eq0dPpVUF1zh6oQCXQbw==
ARC-Authentication-Results: i=1;
        rspamd-766d96cb5b-6njkk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Average: 16c87f12391b59a7_1678998238685_4263010003
X-MC-Loop-Signature: 1678998238685:2361967255
X-MC-Ingress-Time: 1678998238684
Received: from pdx1-sub0-mail-a290.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.117.156.21 (trex/6.7.2);
        Thu, 16 Mar 2023 20:23:58 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a290.dreamhost.com (Postfix) with ESMTPSA id 4PczHd4ST8zHB;
        Thu, 16 Mar 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1678998238;
        bh=zzZZTZnF4mgkGlPMN+EAoe0gpBwte5d92YbdLcYCzn0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=M3WEc1QTfiP3WR9EvHG8kCXLeJLw3P0yRrLLxG1JwRF8/K67ksBa8WFiq5PF+25WV
         OM1MFHdFccjD4nzRWm14nOzfsB5SwZWUyjF6eu0UpdvPpKfv1SI047jopf8Sf3DIrM
         Y4Bn8s/GLau24WREKreR5YoFEOpXmaGc4G6KcoRdnX8Sy5JXROzOPhWM00L/hQCAx7
         d5a5mNt1n9DSYNH2RCG6IYkSHxW9BHI4LQ2IhZqKotM9hdcSutTIOc/ABpod4GYLBg
         mzPuc3ERirE82G7FMRCxogcJv5d5ZlVpPDf1mzrjV13WdLkcPOrJ9ee6T6Xl+OVIqc
         690KD1j3mvPmw==
Date:   Thu, 16 Mar 2023 12:54:26 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] ACPI: APEI: EINJ: Add CXL error types
Message-ID: <20230316195426.x7wmzzf32sucfk7l@offworld>
References: <20230314004611.48583-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230314004611.48583-1-tony.luck@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023, Tony Luck wrote:

>ACPI 6.5 added six new error types for CXL. See chapter 18
>table 18.30.
>
>Add strings for the new types so that Linux will list them in the
>/sys/kernel/debug/apei/einj/available_error_types file.
>
>It seems no other changes are needed. Linux already accepts
>the CXL codes (on a BIOS that advertises them).
>
>Signed-off-by: Tony Luck <tony.luck@intel.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> drivers/acpi/apei/einj.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>index b4373e575660..39bee5a067cc 100644
>--- a/drivers/acpi/apei/einj.c
>+++ b/drivers/acpi/apei/einj.c
>@@ -584,6 +584,12 @@ static const char * const einj_error_type_string[] = {
>	"0x00000200\tPlatform Correctable\n",
>	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>	"0x00000800\tPlatform Uncorrectable fatal\n",
>+	"0x00001000\tCXL.cache Protocol Correctable\n",
>+	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>+	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>+	"0x00008000\tCXL.mem Protocol Correctable\n",
>+	"0x00010000\tCXL.mem Protocol Uncorrectable non-fatal\n",
>+	"0x00020000\tCXL.mem Protocol Uncorrectable fatal\n",
> };
>
> static int available_error_type_show(struct seq_file *m, void *v)
>--
>2.39.2
>
