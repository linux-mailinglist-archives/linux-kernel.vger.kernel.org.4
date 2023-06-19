Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E151735B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjFSPsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFSPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:48:17 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B2CA4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:48:11 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id DADEAE80B90;
        Mon, 19 Jun 2023 17:48:06 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 976551601D3; Mon, 19 Jun 2023 17:48:06 +0200 (CEST)
Date:   Mon, 19 Jun 2023 17:48:06 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Babis Chalios <bchalios@amazon.es>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 1/1] vmgenid: emit uevent when VMGENID updates
Message-ID: <ZJB4trdk42vghv/o@gardel-login>
References: <20230531095119.11202-1-bchalios@amazon.es>
 <20230531095119.11202-2-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095119.11202-2-bchalios@amazon.es>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 31.05.23 11:51, Babis Chalios (bchalios@amazon.es) wrote:

> We receive an ACPI notification every time the VM Generation ID changes
> and use the new ID as fresh randomness added to the entropy pool. This
> commits emits a uevent every time we receive the ACPI notification, as a
> means to notify the user space that it now is in a new VM.
>
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
>  drivers/virt/vmgenid.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
> index a1c467a0e9f7..b67a28da4702 100644
> --- a/drivers/virt/vmgenid.c
> +++ b/drivers/virt/vmgenid.c
> @@ -68,6 +68,7 @@ static int vmgenid_add(struct acpi_device *device)
>  static void vmgenid_notify(struct acpi_device *device, u32 event)
>  {
>  	struct vmgenid_state *state = acpi_driver_data(device);
> +	char *envp[] = { "NEW_VMGENID=1", NULL };
>  	u8 old_id[VMGENID_SIZE];
>
>  	memcpy(old_id, state->this_id, sizeof(old_id));
> @@ -75,6 +76,7 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
>  	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
>  		return;
>  	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
> +	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
>  }
>
>  static const struct acpi_device_id vmgenid_ids[] = {

Beautifully simple. Looks good to me. Would love to make use of this from systemd.

Reviewed-by: Lennart Poettering <mzxreary@0pointer.de>

Lennart

--
Lennart Poettering, Berlin
