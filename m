Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C89689F85
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjBCQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjBCQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:45:45 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1019E6ACA0;
        Fri,  3 Feb 2023 08:45:41 -0800 (PST)
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313DFwBj029549;
        Fri, 3 Feb 2023 16:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=li99j8KUXV7sp8YgQ+hZE5WbX/5DbHPcVWqBJmiKMeI=;
 b=I+3G2FuWGaPP/5AK+BESeRdbHJA6Jrzf6K+aA976kOiWVoZqaP8nj+zMN593ADyMSDOZ
 2qgnr1nB1IXfxZWJUH98EyKl0DBj6lMc/38v6pZW2znUSfmFa/3cia4mHdkmIeGJKacH
 KHUJNv73FGwfKYKsgkSNpegwenKegFCDxns4CRb1AGP1d86JoNU4yvHr0nJd3+17IabQ
 O3CP2Pg9MaA2wdzngN6rWeBQyVxZmP2bw2wOqAJDMajo3niF7UDIGXIFj3r7PpK15LNz
 NshRzQcgFNxZ0jw8hA2e9+RF911QbTnn+pUmaD5hTFJai42+f63KI2ZI8XvV83k85pTb 8A== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 3nh303m3da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 16:45:35 +0000
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 313DTBxA016751;
        Fri, 3 Feb 2023 11:45:34 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 3neyyge51g-1;
        Fri, 03 Feb 2023 11:45:34 -0500
Received: from [172.19.32.122] (bos-lpa4700a.bos01.corp.akamai.com [172.19.32.122])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id C454D30558;
        Fri,  3 Feb 2023 16:45:33 +0000 (GMT)
Message-ID: <04311d93-7cb4-bf0b-dfa7-162a38b42583@akamai.com>
Date:   Fri, 3 Feb 2023 11:45:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] dyndbg: add source filename to prefix
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
 <20221223-dyndbg-filename-v1-3-cbf8543009a1@weissschuh.net>
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20221223-dyndbg-filename-v1-3-cbf8543009a1@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030152
X-Proofpoint-ORIG-GUID: A9g6yo08fzAe71Mbvzb8okEDCBNbFWB6
X-Proofpoint-GUID: A9g6yo08fzAe71Mbvzb8okEDCBNbFWB6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_15,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302030153
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for this series, this series is fine with me:
Acked-by: Jason Baron <jbaron@akamai.com>

Your comment about making the output more relatable to the control file 
made me think if we should try and make the logged output look more like 
the control file:

# cat /proc/dynamic_debug/control
# filename:lineno [module]function flags format

So for your example, I think that would look like:

[   71.802212] lib/test_dynamic_debug.c:103 do_cats: test_dd: doing 
categories
[   71.802227] lib/test_dynamic_debug.c:123 do_levels: doing levels

But even if we think it looks better, there maybe too many dependencies 
on the current output format...

Thanks,

-Jason

On 1/29/23 9:01 PM, Thomas Weißschuh wrote:
> Printing the line number without the file is of limited usefulness.
> 
> Knowing the filename also makes it also easier to relate the logged
> information to the controlfile.
> 
> Example:
> 
>      # modprobe test_dynamic_debug
>      # echo 'file test_dynamic_debug.c =pfsl' > /proc/dynamic_debug/control
>      # echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
>      # dmesg | tail -2
>      [   71.802212] do_cats:lib/test_dynamic_debug.c:103: test_dd: doing categories
>      [   71.802227] do_levels:lib/test_dynamic_debug.c:123: test_dd: doing levels
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
>   include/linux/dynamic_debug.h                     | 4 +++-
>   lib/dynamic_debug.c                               | 4 ++++
>   3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index faa22f77847a..f9fa8163fba6 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -216,13 +216,14 @@ The flags are::
>     t    Include thread ID, or <intr>
>     m    Include module name
>     f    Include the function name
> +  s    Include the source file name
>     l    Include line number
>   
>   For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
>   the ``p`` flag has meaning, other flags are ignored.
>   
> -Note the regexp ``^[-+=][flmpt_]+$`` matches a flags specification.
> -To clear all flags at once, use ``=_`` or ``-flmpt``.
> +Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
> +To clear all flags at once, use ``=_`` or ``-fslmpt``.
>   
>   
>   Debug messages during Boot Process
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
> index 41682278d2e8..0c77105d583c 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -37,10 +37,12 @@ struct _ddebug {
>   #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
>   #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
>   #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
> +#define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
>   
>   #define _DPRINTK_FLAGS_INCL_ANY		\
>   	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
> -	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
> +	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
> +	 _DPRINTK_FLAGS_INCL_SOURCENAME)
>   
>   #if defined DEBUG
>   #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index e96ea427d8af..fa7418e35197 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -92,6 +92,7 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
>   	{ _DPRINTK_FLAGS_PRINT, 'p' },
>   	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
>   	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
> +	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
>   	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
>   	{ _DPRINTK_FLAGS_INCL_TID, 't' },
>   	{ _DPRINTK_FLAGS_NONE, '_' },
> @@ -836,6 +837,9 @@ static char *__dynamic_emit_prefix(const struct _ddebug *desc, char *buf)
>   	if (desc->flags & _DPRINTK_FLAGS_INCL_FUNCNAME)
>   		pos += snprintf(buf + pos, remaining(pos), "%s:",
>   				desc->function);
> +	if (desc->flags & _DPRINTK_FLAGS_INCL_SOURCENAME)
> +		pos += snprintf(buf + pos, remaining(pos), "%s:",
> +				trim_prefix(desc->filename));
>   	if (desc->flags & _DPRINTK_FLAGS_INCL_LINENO)
>   		pos += snprintf(buf + pos, remaining(pos), "%d:",
>   				desc->lineno);
> 
